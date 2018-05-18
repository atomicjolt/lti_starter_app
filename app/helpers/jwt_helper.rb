module JwtHelper

  def jwt_token
    return unless signed_in?
    attrs = {
      user_id: current_user.id,
    }
    if @is_lti_launch
      # Only trust these values if the current request is an LTI launch
      attrs[:lti_roles] = current_user_roles(context_id: params[:context_id])
      attrs[:context_id] = params[:context_id]
      attrs[:lms_course_id] = params[:custom_canvas_course_id]
      attrs[:kid] = params[:oauth_consumer_key]
    end
    AuthToken.issue_token(attrs)
  end

end
