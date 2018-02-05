module Concerns
  module CanvasImsccSupport
    extend ActiveSupport::Concern

    included do
      before_action :validate_token
      skip_before_action :verify_authenticity_token
      respond_to :json
    end

    protected

    def validate_token
      decoded_token = AuthToken.decode(encoded_token, nil, false)
      lti_key = decoded_token[1]["kid"]
      if application_instance = ApplicationInstance.find_by(lti_key: lti_key)
        token = AuthToken.valid?(encoded_token, application_instance.lti_secret)
        raise InvalidTokenError, "Unable to decode IMSCC jwt token" if token.blank?
        raise InvalidTokenError, "Invalid IMSCC jwt token payload" if token.empty?
        token[0]
      else
        raise Exceptions::InvalidImsccTokenError, "LTI key provided does not match any known application instances."
      end
    rescue JWT::DecodeError, Exceptions::InvalidImsccTokenError => ex
      user_not_authorized("Unauthorized: Invalid token: #{ex}")
    end

    def encoded_token
      bearer_token = request.headers["Authorization"] || request.headers[:authorization]
      raise Exceptions::InvalidImsccTokenError, "Empty authorization header." if bearer_token.blank?
      unless bearer_token.start_with?("Bearer ")
        raise Exceptions::InvalidImsccTokenError, "Invalid authorization header."
      end
      token = bearer_token.split(" ").last
      raise Exceptions::InvalidImsccTokenError, "Empty IMSCC JWT token." if token.blank?
      token
    end

  end
end
