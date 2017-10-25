module Concerns
  module JwtToken
    extend ActiveSupport::Concern

    included do
      helper_method :jwt_token
    end

    class InvalidTokenError < StandardError; end

    def jwt_token
      return unless signed_in?
      attrs = {
        user_id: current_user.id,
      }
      if @is_lti_launch
        # Only trust these values if the current request is an LTI launch
        attrs[:lti_roles] = current_user_roles(context_id: params[:context_id])
        attrs[:context_id] = params[:context_id]
        attrs[:lms_course_id] = params[:custom_canvas_course_id]
      end
      AuthToken.issue_token(attrs)
    end

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

    def jwt_context_id
      token = decoded_jwt_token(request)
      token["context_id"]
    end

    def jwt_lti_roles
      token = decoded_jwt_token(request)
      token["lti_roles"]
    end

    def jwt_lms_course_id
      token = decoded_jwt_token(request)
      token["lms_course_id"]
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
