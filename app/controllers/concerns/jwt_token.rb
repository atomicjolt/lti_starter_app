module Concerns
  module JwtToken
    extend ActiveSupport::Concern

    class InvalidTokenError < StandardError; end

    def decoded_jwt_token(req, secret = nil)
      token = AuthToken.valid?(encoded_token(req), secret)
      raise InvalidTokenError, "Unable to decode jwt token" if token.blank?
      raise InvalidTokenError, "Invalid token payload" if token.empty?
      token[0]
    end

    def validate_token_with_secret(aud, secret, req = request)
      token = decoded_jwt_token(req, secret)
      raise InvalidTokenError if aud != token["aud"]
    rescue JWT::DecodeError, InvalidTokenError
      render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
    end

    def validate_token
      token = decoded_jwt_token(request)
      raise InvalidTokenError if Rails.application.secrets.auth0_client_id != token["aud"]
      @user = User.find(token["user_id"])
      sign_in(@user, event: :authentication)
    rescue JWT::DecodeError, InvalidTokenError
      render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
    end

    def can_access_course?(lms_course_id)
      jwt_lms_course_id.to_s == lms_course_id.to_s
    end

    def can_admin_course?(lms_course_id)
      can_access_course?(lms_course_id) && lti_admin_or_instructor?
    end

    def lti_instructor?
      jwt_lti_roles_string.match(/urn:lti:role:ims\/lis\/Instructor/).present?
    end

    def lti_admin?
      (
        jwt_lti_roles_string.match(/urn:lti:role:ims\/lis\/Administrator/) ||
        jwt_lti_roles_string.match(/urn:lti:instrole:ims\/lis\/Administrator/) ||
        jwt_lti_roles_string.match(/urn:lti:sysrole:ims\/lis\/SysAdmin/) ||
        jwt_lti_roles_string.match(/urn:lti:sysrole:ims\/lis\/Administrator/)
      ).present?
    end

    def lti_admin_or_instructor?
      lti_instructor? || lti_admin?
    end

    def jwt_context_id
      token = decoded_jwt_token(request)
      token["context_id"]
    end

    def jwt_lti_roles
      token = decoded_jwt_token(request)
      token["lti_roles"] || []
    end

    def jwt_lms_course_id
      token = decoded_jwt_token(request)
      token["lms_course_id"]
    end

    def jwt_lti_roles_string
      jwt_lti_roles.join(",")
    end

    protected

    def encoded_token(req)
      header = req.headers["Authorization"] || req.headers[:authorization]
      raise InvalidTokenError, "No authorization header found" if header.nil?
      token = header.split(" ").last
      raise InvalidTokenError, "Invalid authorization header string" if token.nil?
      token
    end

  end
end
