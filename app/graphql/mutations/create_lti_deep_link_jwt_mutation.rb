class Mutations::CreateLtiDeepLinkJwtMutation < Mutations::BaseMutation
  include Concerns::DeepLinking

  null true

  argument :type, String, required: true

  field :deep_link_jwt, String, null: false
  field :errors, [String], null: false

  def resolve(type:)
    params = {}
    params[:type] = type

    deep_link_jwt = create_deep_link_jwt(
      application_instance: context[:current_application_instance],
      token: context[:token],
      params: params,
      jwt_context_id: context[:jwt_context_id],
      jwt_tool_consumer_instance_guid: context[:jwt_tool_consumer_instance_guid],
      host: context[:host],
    )
    {
      deep_link_jwt: deep_link_jwt,
      errors: [],
    }
  end
end
