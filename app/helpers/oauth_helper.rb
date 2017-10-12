module OauthHelper
  ##
  # oauth_host
  #
  # Allows the use of multiple subdomains listed as the root domain
  ##
  def oauth_host
    "#{Application::AUTH}.#{Rails.application.secrets.application_root_domain}"
  end
end
