module ApplicationHelper

  def canvas_url
    session[:canvas_url] || current_lti_application_instance.lti_consumer_uri
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

end
