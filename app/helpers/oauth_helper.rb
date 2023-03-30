module OauthHelper
  def oauth_jwt(application_instance:, user: nil, oauth_complete_url: nil, canvas_url: nil)
    OauthJwt.issue_token(
      site: application_instance.site,
      application_instance: application_instance,
      user: user,
      app_callback_url: user_canvas_omniauth_callback_url,
      oauth_complete_url: oauth_complete_url,
      canvas_url: canvas_url,
    )
  end

  def can_oauth?
    true
  end
end
