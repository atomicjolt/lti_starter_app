require "rails_helper"

RSpec.describe LtiLaunch, type: :model do
  it "has a secure token" do
    lti_launch = LtiLaunch.create!
    expect(lti_launch.token).to be
  end
end
