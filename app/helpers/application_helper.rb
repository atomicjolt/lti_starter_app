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
      },
    )
  end

  def lti_roles
    params["ext_roles"] || params["roles"]
  end

  ##
  # oauth_host
  #
  # Allows the use of multiple subdomains listed as the root domain
  ##
  def oauth_host
    "#{Application::AUTH}.#{Rails.application.secrets.application_root_domain}"
  end

end
