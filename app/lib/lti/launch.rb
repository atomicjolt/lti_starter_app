module Lti
  class Launch

    def self.params(
      oauth_consumer_key = "aconsumerkey",
      oauth_consumer_secret = "secret",
      options = {}
    )
      raise "launch_url is a required parameter" unless options["launch_url"].present? || options[:launch_url].present?
      launch_request = IMS::LTI::Models::Messages::BasicLTILaunchRequest.new(options)
      launch_request.oauth_consumer_key = oauth_consumer_key
      yield launch_request if block_given?
      launch_request.signed_post_params(oauth_consumer_secret).stringify_keys
    end

    def self.launch_params(
      user:,
      context_id:,
      oauth_consumer_key:,
      oauth_consumer_secret:,
      options: {}
    )
      new_options = options.merge(user_options(user, context_id))
      params(oauth_consumer_key, oauth_consumer_secret, new_options)
    end

    def self.content_item_select_params(
      user:,
      context_id:,
      oauth_consumer_key:,
      oauth_consumer_secret:,
      content_item_return_url:,
      options: {}
    )
      content_item_options = {
        launch_presentation_document_target: "iframe",
        content_item_return_url: content_item_return_url,
        accept_multiple: false,
        accept_media_types: %w(image/* text/html application/vnd.ims.lti.v1.ltilink */*).join(","),
        accept_presentation_document_targets: %w(embed frame iframe window).join(","),
        accept_unsigned: true,
        auto_create: false,
      }
      new_options = options.merge(user_options(user, context_id)).merge(content_item_options)
      params(oauth_consumer_key, oauth_consumer_secret, new_options) do |launch_request|
        launch_request.lti_message_type = "ContentItemSelectionRequest"
      end
    end

    def self.user_options(user, context_id)
      roles = user.context_roles(context_id).pluck(:name).join(",")
      {
        lti_version: "LTI-1p0",
        user_id: user.lti_user_id,
        lis_person_name_full: user.display_name,
        lis_person_name_family: user.last_name,
        lis_person_name_given: user.first_name,
        lis_person_contact_email_primary: user.email,
        lis_person_sourced_id: "atomicjolt.com:user:#{user.id}",
        roles: roles,
        ext_roles: roles,
        context_id: context_id,
      }
    end
  end
end
