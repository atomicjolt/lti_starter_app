require 'rails_helper'

RSpec.describe LtiApplication, type: :model do

  describe "create lti application" do
    before do
      @lti_consumer_uri = "example.com"
    end

    it "requires a name" do
      expect {
        described_class.create!(description: "a test")
      }.to raise_exception(ActiveRecord::RecordInvalid)
    end

  end

end
