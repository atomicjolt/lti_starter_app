class Types::HelloWorldMutationType < Types::BaseObject
  field :create_lti_deep_link_jwt, mutation: Mutations::CreateLtiDeepLinkJwtMutation
end
