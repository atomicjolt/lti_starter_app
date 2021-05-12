module JwtHelper

  def jwt_token(app_callback_url: nil, oauth_complete_url: nil)
    return unless signed_in?

    attrs = {
      user_id: current_user.id,
      application_instance_id: current_application_instance.id,
    }

    if app_callback_url
      attrs[:app_callback_url] = app_callback_url
    end

    if oauth_complete_url
      attrs[:oauth_complete_url] = oauth_complete_url
    end

    # Only trust these values if the current request is an LTI launch
    if @lti_token
      attrs[:iss] = @lti_token["iss"]
      attrs[:deployment_id] = @lti_token[LtiAdvantage::Definitions::DEPLOYMENT_ID]
      attrs[:data] = @lti_token[LtiAdvantage::Definitions::DEEP_LINKING_DATA_CLAIM]
      context_id = @lti_token.dig(LtiAdvantage::Definitions::CONTEXT_CLAIM)["id"]
      attrs[:lti_roles] = current_user_roles(context_id: context_id)
      attrs[:context_id] = context_id
      attrs[:lms_course_id] = @lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "canvas_course_id")
      attrs[:kid] = current_application_instance.lti_key
    elsif @is_lti_launch

      attrs[:lti_roles] = current_user_roles(context_id: params[:context_id])
      attrs[:context_id] = params[:context_id]
      attrs[:lms_course_id] = params[:custom_canvas_course_id]
      attrs[:kid] = params[:oauth_consumer_key]
    end

    AuthToken.issue_token(attrs)
  end

end
