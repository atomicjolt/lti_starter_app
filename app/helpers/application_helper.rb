module ApplicationHelper

  def application_base_url
    File.join(request.base_url, "/")
  end

  def jwt_token
    return unless signed_in?
    AuthToken.issue_token(
      {
        user_id: current_user.id,
        lti_roles: lti_roles,
        lms_course_id: params[:custom_canvas_course_id],
      },
    )
  end

  def lti_roles
    params["ext_roles"] || params["roles"]
  end

end
