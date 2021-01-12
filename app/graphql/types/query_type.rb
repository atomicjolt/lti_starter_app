class Types::QueryType < Types::BaseObject
  description "The root query of this schema"

  field :lti_launch, Types::LtiLaunchType, null: false do
    description "An lti launch with the given id"
    argument :id, ID, required: true
    guard ->(_obj, _args, ctx) {
      ctx[:current_user].admin? ||
        ctx[:current_user].can_author?(ctx[:jwt_context_id], ctx[:current_application_instance])
    }
  end

  def lti_launch(id:)
    lti_launch = LtiLaunch.find_by(id: id, application_instance_id: ctx[:current_application_instance].id)
    if lti_launch.lti_context&.context_id != ctx[:jwt_context_id]
      return nil
    end

    lti_launch
  end
