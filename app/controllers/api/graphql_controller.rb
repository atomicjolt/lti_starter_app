class Api::GraphqlController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  # Defined in order of increasing specificity.
  rescue_from Exception, with: :internal_error
  rescue_from GraphQL::ParseError, with: :invalid_query
  rescue_from JSON::ParserError, with: :invalid_variables
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from GraphQL::Guard::NotAuthorizedError, with: :permission_denied

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    canvas_api_proc = Proc.new do |type|
      if canvas_api_authorized(type: type, context_id: jwt_context_id) && custom_api_checks_pass(type: type)
        canvas_api(
          application_instance: current_application_instance,
          user: current_user,
          canvas_course: CanvasCourse.find_by(lms_course_id: jwt_lms_course_id),
        )
      else
        raise(
          Exceptions::UnAuthorizedGraphQLCanvasRequest,
          "You are not authorized to access the #{type} Canvas API endpoint.",
        )
      end
    end
    context = {
      host: request.host,
      current_user: current_user,
      token: decoded_jwt_token(request),
      jwt_lms_course_id: jwt_lms_course_id,
      jwt_context_id: jwt_context_id,
      jwt_tool_consumer_instance_guid: jwt_tool_consumer_instance_guid,
      current_application_instance: current_application_instance,
      current_ability: Ability.new(current_user, jwt_context_id),
      current_host: request.host,
      canvas_api: canvas_api_proc,
    }
    result = schema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def render_error(status, message)
    render json: {
      errors: [{ message: message }],
    }, status: status
  end

  def invalid_request(message)
    render_error 400, message
  end

  def permission_denied
    render_error 403, "Permission denied"
  end

  def invalid_query
    invalid_request "Unable to parse query"
  end

  def invalid_variables
    invalid_request "Unable to parse variables"
  end

  def not_found
    render_error 404, "Unable to find the requested record"
  end

  def internal_error(err)
    Rails.logger.error "Unexpected exception during execution"
    Rails.logger.error "#{err.class.name} (#{err.message}):"
    Rails.logger.error "  #{err.backtrace.join("\n  ")}"
    Rollbar.error(err) if current_application_instance.rollbar_enabled?
    render_error 500, "Internal error: #{err.message}"
  end

  def schema
    raise "controller subclass must define a schema method!"
  end
end
