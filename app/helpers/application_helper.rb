module ApplicationHelper

  def canvas_url
    session[:canvas_url] || Rails.application.secrets.canvas_url
  end

  def application_base_url
    File.join(request.base_url, "/")
  end

  def jwt_token
    return unless signed_in?
    AuthToken.issue_token({
      user_id: current_user.id,
      lti_roles: params["roles"]
    })
  end

  def course_id
    params[:custom_canvas_course_id]
  end

  def user_id
    params[:custom_canvas_user_id]
  end

end
