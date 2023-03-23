module LtiHelper
  def current_context_id
    if @lti_token
      @lti_token.dig(AtomicLti::Definitions::CONTEXT_CLAIM)["id"]
    elsif @is_lti_launch
      params[:context_id]
    else
      raise LtiContextUnavailable.new("Context id is not available in the current request")
    end
  end

  # Return a deep-linking style placement for Canvas content item embeds
  def canvas_content_item_placement
    return nil if params[:lti_message_type] != "ContentItemSelectionRequest"

    if params[:ext_lti_assignment_id].present?
      "assignment_selection"
    elsif params[:accept_media_types] == "application/vnd.ims.lti.v1.ltilink"
      "link_selection"
    elsif params[:accept_media_types]&.split(",")&.include?("text/html")
      "editor_button"
    else
      nil
    end
  end

  def lti_launch_email
    if lti_advantage?
      lti.token["email"]
    elsif lti_launch?
      params["lis_person_contact_email_primary"]
    else
      nil
    end
  end
end
