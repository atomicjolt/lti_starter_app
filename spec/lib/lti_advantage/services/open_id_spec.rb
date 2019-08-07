require "rails_helper"

RSpec.describe LtiAdvantage::OpenId do
  describe "validate_open_id_state" do
    it "validates state provided by the platform" do
      state = LtiAdvantage::OpenId.state
      expect(state).to be
    end
  end
  describe "state" do
    it "generates state to be sent to the platform" do
      state = LtiAdvantage::OpenId.state
      expect(LtiAdvantage::OpenId.validate_open_id_state(state)).to be true
    end
  end
end
