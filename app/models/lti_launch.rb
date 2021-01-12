class LtiLaunch < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer
  belongs_to :lti_context, optional: true
  belongs_to :lti_deployment, optional: true
  belongs_to :application_instance, optional: true
  belongs_to :parent, optional: true, class_name: :LtiLaunch

  def to_param
    token
  end

  def self.decode_history(lti_history)
    # LTI passes the history as a comma-separated list of url-encoded ids.
    return nil if !lti_history

    lti_history.split(",").map { |id| URI.decode_www_form_component id }
  end

  def self.lti_advantage_launch(token:, lti_token:, application_instance:)
    context_claim = lti_token[LtiAdvantage::Definitions::CONTEXT_CLAIM]
    resource_link_claim = lti_token[LtiAdvantage::Definitions::RESOURCE_LINK_CLAIM]
    platform_claim = lti_token[LtiAdvantage::Definitions::TOOL_PLATFORM_CLAIM]
    # context_id_history = LtiLaunch.decode_history(
    #   lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "context_id_history"),
    # )
    resource_link_id_history = decode_history(
      lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "resource_id_history"),
    )

    lti_launch = launch(
      token: token,
      context_id: context_claim["id"],
      resource_link_id: resource_link_claim["id"],
      resource_link_id_history: resource_link_id_history,
      application_instance: application_instance,
    )
    return if !lti_launch

    resource_title = resource_link_claim["title"]
    lti_launch.update(title: resource_title) if resource_title

    # Update lti context
    if !lti_launch.lti_context
      lti_deployment = LtiDeployment.find_by!(
        deployment_id: lti_token[LtiAdvantage::Definitions::DEPLOYMENT_ID],
      )
      lti_launch.lti_context = LtiContext.find_or_create_by(
        context_id: context_claim["id"],
        lti_deployment_id: lti_deployment.id,
      )
      lti_launch.save
    end
    lti_launch.lti_context.update(context_claim.slice("label", "title"))

    # Update lti platform instance
    if platform_claim
      lti_deployment = lti_launch.lti_context.lti_deployment
      if !lti_deployment.lti_platform_instance
        lti_deployment.lti_platform_instance = LtiPlatformInstance.find_or_create_by(
          guid: platform_claim["guid"],
          iss: lti_deployment.lti_install.iss,
        )
        lti_deployment.save
      end
      lti_deployment.lti_platform_instance.update(platform_claim.slice("name", "product_family_code"))
    end
    lti_launch
  end

  def self.launch(
    token:,
    context_id:,
    resource_link_id:,
    resource_link_id_history: nil,
    application_instance:
  )
    # Check for a normal launch where all parameters match.
    lti_launch = LtiLaunch.find_by(
      token: token,
      context_id: context_id,
      resource_link_id: resource_link_id,
      application_instance_id: application_instance.id,
    )
    return lti_launch if lti_launch

    # See if there is a match with a nil resource_link_id.  We don't know the
    # resource_link_id until after the deep linking finishes, so the first
    # launch will be like this. This also handles the case of launches created
    # before we added the resource_link_id to lti_launches.
    #
    # Note that a missing resource_link_id is an empty string rather than a null because
    # we want postgres to enforce a uniqueness constraint. We are guaranteed to have
    # at most one match here.
    lti_launch = LtiLaunch.find_by(
      token: token,
      context_id: context_id,
      resource_link_id: "",
      application_instance_id: application_instance.id,
    )
    if lti_launch
      lti_launch.update(resource_link_id: resource_link_id)
      return lti_launch
    end

    # We don't have an exact match, which probably means the launch was copied in
    # the LMS. Create a new unconfigured launch.
    lti_launch = LtiLaunch.new(
      token: token,
      context_id: context_id,
      resource_link_id: resource_link_id,
      application_instance_id: application_instance.id,
      is_configured: false,
    )

    # Look for a matching launch by resource_link_id_history, searching in
    # reverse chronologoical order.
    resource_link_id_history&.each do |id|
      lti_launches = LtiLaunch.where(
        token: token,
        resource_link_id: id,
        is_configured: true,
      )
      if lti_launches.count == 1
        # We can assume this is the correct launch to copy, so set the parent.
        lti_launch.parent = lti_launches.first
        break
      end
      if lti_launches.count > 1
        # Bail if there are multiple matching records with the same resource_link_id.
        # The resource_link_id is only guaranteed to be unique within a deployment so this
        # is an ambiguous case.
        break
      end
    end

    lti_launch.save!
    lti_launch
  end

  def matching_launches(lti_token)
    context_id_history = LtiLaunch.decode_history(
      lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "canvas_context_id_history"),
    )
    resource_link_id_history = LtiLaunch.decode_history(
      lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "resource_id_history"),
    )
    # Search for the same resource_link_id in a different application instance.
    lti_launches = LtiLaunch.where(
      token: token,
      context_id: context_id,
      resource_link_id: resource_link_id,
      is_configured: true,
    ).order("created_at DESC")
    if lti_launches.present?
      return lti_launches
    end

    # Search by resource_link_id_history if it's present.
    if resource_link_id_history.present?
      resource_link_id_history.each do |id|
        lti_launches = LtiLaunch.where(
          token: token,
          resource_link_id: id,
          is_configured: true,
        ).order("created_at DESC")
        if lti_launches.present?
          return lti_launches
        end
      end
      # No matches, so stop searching
      return []
    end

    # Otherwise lookup by context_id_history, although this won't necessarily represent
    # the history of this particular lti link.  We return the list of all matching launches
    # across all contexts, ordered by most recently created.
    #
    # Canvas: The context.id.history is a course-level history which includes all imports (selective or full) in
    # reverse chronological order.
    #
    # Moodle: The context.id.history lists only a chain of course restores used to create courses initially,
    # and not subsequent restores.  Any course created blank and then restored into will have only the
    # current context_id listed, even though lti links may have been restored.

    if context_id_history.present?
      lti_launches = LtiLaunch.where(
        token: token,
        context_id: context_id_history,
        is_configured: true,
      ).order("created_at DESC")
      if lti_launches.present?
        return lti_launches
      end
    end

    # Finally look for token matches in the same context.
    lti_launches = LtiLaunch.where(
      token: token,
      context_id: context_id,
      is_configured: true,
    ).order("created_at DESC")
    if lti_launches.present?
      return lti_launches
    end

    []
  end

  # Settings passed to client during launch
  def client_settings(lti_token, can_author)
    settings = {}
    settings[:lti_launch_config] = config
    settings[:lti_launch_id] = id
    settings[:lti_launch_is_configured] = is_configured
    if !is_configured && can_author
      settings[:lti_matching_launches] = matching_launches(lti_token).map(&:to_settings)
    end
    settings
  end

  def to_settings(can_author = true)
    {
      id: id,
      token: token,
      resource_link_id: resource_link_id,
      title: title,
      config: config,
      created_at: created_at,
      context: lti_context&.to_settings(can_author),
    }
  end
end
