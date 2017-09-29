module Concerns
  module JwtToken
    extend ActiveSupport::Concern

    class InvalidTokenError < StandardError; end

    def validate_token_with_secret(aud, secret)
      authorization = request.headers["Authorization"]
      raise InvalidTokenError if authorization.nil?

      token = request.headers["Authorization"].split(" ").last
      decoded_token = AuthToken.valid?(token, secret)

      raise InvalidTokenError if aud != decoded_token[0]["aud"]
    rescue JWT::DecodeError, InvalidTokenError
      render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
    end

    def validate_token
      authorization = request.headers["Authorization"]
      raise InvalidTokenError if authorization.nil?

      token = request.headers["Authorization"].split(" ").last
      decoded_token = AuthToken.valid?(token)[0]

      raise InvalidTokenError if Rails.application.secrets.auth0_client_id != decoded_token["aud"]

      @jwt_lti_roles = decoded_token["lti_roles"]
      @jwt_lms_course_id = decoded_token["lms_course_id"]
      @jwt_user = User.find(decoded_token["user_id"])

      sign_in(@jwt_user, event: :authentication)
    rescue JWT::DecodeError, InvalidTokenError
      render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
    end

    def can_access_course?(lms_course_id)
      @jwt_lms_course_id == lms_course_id
    end

    def can_admin_course?(lms_course_id)
      can_access_course?(lms_course_id) && (
        @jwt_lti_roles.match(/urn:lti:role:ims\/lis\/Administrator/) ||
          @jwt_lti_roles.match(/urn:lti:role:ims\/lis\/Instructor/)
      )
    end

  end
end
