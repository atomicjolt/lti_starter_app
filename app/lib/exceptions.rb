module Exceptions
  class ManifestMissing < StandardError
  end
  class LtiConfigMissing < StandardError
  end
  class InvalidImsccTokenError < StandardError
  end
end
