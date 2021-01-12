class Mutations::CopyLtiLaunchMutation < Mutations::BaseMutation
  include Concerns::LtiCopySupport

  argument :id, ID, required: true
  argument :source_id, ID, required: true
  argument :secure_token, String, required: true

  field :lti_launch, Types::LtiLaunchType, null: false

  def resolve(id:, source_id:, secure_token:)
    lti_launch = copy_lti_launch(
      application_instance: context[:current_application_instance],
      lti_launch_id: id,
      source_lti_launch_id: source_id,
      secure_token: secure_token,
    )
    { lti_launch: lti_launch }
  end
end
