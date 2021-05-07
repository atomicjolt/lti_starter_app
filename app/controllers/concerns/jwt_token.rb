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
  rescue JWT::DecodeError, InvalidTokenError => e
    Rails.logger.error "JWT Error occured: #{e.inspect}"
    render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
  end

  def validate_token
    token = decoded_jwt_token(request)
    raise InvalidTokenError if Rails.application.secrets.auth0_client_id != token["aud"]
    raise InvalidTokenError if current_application_instance.id != token["application_instance_id"]

    @user = User.find(token["user_id"])
    sign_in(@user, event: :authentication)
  rescue JWT::DecodeError, InvalidTokenError => e
    Rails.logger.error "JWT Error occured #{e.inspect}"
    render json: { error: "Unauthorized: Invalid token." }, status: :unauthorized
  end

  def can_access_course?(lms_course_id)
    jwt_lms_course_id.to_s == lms_course_id.to_s
  end

  def can_admin_course?(lms_course_id)
    can_access_course?(lms_course_id) && lti_admin_or_instructor_or_allowed?
  end

  def lti_instructor?
    jwt_lti_roles_string.include?("urn:lti:role:ims/lis/Instructor")
  end

  def lti_ta?
    jwt_lti_roles_string.include?("urn:lti:role:ims/lis/TeachingAssistant")
  end

  def lti_content_developer?
    jwt_lti_roles_string.include?("urn:lti:role:ims/lis/ContentDeveloper")
  end

  def lti_admin?
    jwt_lti_roles_string.include?("urn:lti:role:ims/lis/Administrator") ||
      jwt_lti_roles_string.include?("urn:lti:instrole:ims/lis/Administrator") ||
      jwt_lti_roles_string.include?("urn:lti:sysrole:ims/lis/SysAdmin") ||
      jwt_lti_roles_string.include?("urn:lti:sysrole:ims/lis/Administrator")
  end

  def lti_admin_or_instructor?
    lti_instructor? || lti_admin?
  end

  def lti_admin_or_instructor_or_allowed?
    lti_instructor? || lti_admin? || lti_ta? || lti_content_developer?
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

  def jwt_tool_consumer_instance_guid
    token = decoded_jwt_token(request)
    token["tool_consumer_instance_guid"]
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
