class Types::LtiLaunchType < Types::BaseObject
  description "An lti launch"

  field :id, ID, null: false
  field :resource_link_id, String, null: false
  field :parent_id, ID, null: true
  field :config, String, null: true
  field :is_configured, Boolean, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: true
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
end
