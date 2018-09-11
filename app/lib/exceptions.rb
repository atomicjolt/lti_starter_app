module Exceptions
  class ManifestMissing < StandardError
  end
  class LtiConfigMissing < StandardError
  end
  class InvalidImsccTokenError < StandardError
  end
  class FileMvException < StandardError
  end
  class CanvasApiTokenRequired < LMS::Canvas::CanvasException
  end
end
