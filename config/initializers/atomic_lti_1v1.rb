# Lookup an lti_secret from an oauth_consumer_key
AtomicLti1v1.secret_provider = Proc.new do |oauth_consumer_key|
  ApplicationInstance.find_by(lti_key: oauth_consumer_key)&.lti_secret
end
