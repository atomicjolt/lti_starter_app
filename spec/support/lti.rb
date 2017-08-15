def lti_params(oauth_consumer_key = "aconsumerkey", oauth_consumer_secret = "secret", options = {})
  Lti::Launch.params(oauth_consumer_key, oauth_consumer_secret, options)
end
