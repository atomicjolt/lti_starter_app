class Mutations::CreateLtiDeepLinkJwtMutation < Mutations::BaseMutation
  include Concerns::DeepLinking

  null true

  argument :type, String, required: true
  argument :title, String, required: false

  field :deep_link_jwt, String, null: false
  field :errors, [String], null: false

  def resolve(type:, title:)
    params = {}
    params[:type] = type
    params[:title] = title

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
