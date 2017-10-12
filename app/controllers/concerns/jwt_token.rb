module Concerns
  module JwtToken
    extend ActiveSupport::Concern

    class InvalidTokenError < StandardError; end

    def validate_token_with_secret(aud, secret, req = request)
      authorization = req.headers["Authorization"] || req.headers[:authorization]
      raise InvalidTokenError if authorization.nil?

      token = authorization.split(" ").last
      decoded_token = AuthToken.valid?(token, secret)

      raise InvalidTokenError if aud != decoded_token[0]["aud"]
    rescue JWT::DecodeError, InvalidTokenError
      render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
    end

    def validate_token
      authorization = request.headers["Authorization"]
      raise InvalidTokenError if authorization.nil?

      token = request.headers["Authorization"].split(" ").last
      decoded_token = AuthToken.valid?(token)

      raise InvalidTokenError if Rails.application.secrets.auth0_client_id != decoded_token[0]["aud"]

      @user = User.find(decoded_token[0]["user_id"])
      sign_in(@user, event: :authentication)
    rescue JWT::DecodeError, InvalidTokenError
      render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
    end

  end
end
