require "rails_helper"

RSpec.describe LtiDeployment, type: :model do
  before do
    @application_instance = FactoryBot.create(:application_instance)
  end

  it "validates application instance" do
    lti_deployment = LtiDeployment.new(deployment_id: "test")
    expect(lti_deployment.valid?).to be false
  end

  it "validates deployment id" do
    lti_deployment = LtiDeployment.new(application_instance: @application_instance)
    expect(lti_deployment.valid?).to be false
  end

  it "creates an lti deployment" do
    lti_deployment = LtiDeployment.new(
      application_instance: @application_instance,
      deployment_id: "test",
    )
    expect(lti_deployment.valid?).to be true
  end
end
