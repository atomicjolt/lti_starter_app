require "rails_helper"

RSpec.describe OauthState, type: :model do
  describe "valid?" do
    it "is true when state is unique" do
      state = "asdf1234"
      oauth_state = create(:oauth_state, state: state)
      expect(oauth_state.valid?).to be true
    end

    it "is false for duplicate state" do
      state = "asdf1234"
      create(:oauth_state, state: state)
      oauth_state = build(:oauth_state, state: state)
      expect(oauth_state.valid?(state)).to be false
    end

    it "is false when state is missing" do
      state = nil
      oauth_state = build(:oauth_state, state: state)
      expect(oauth_state.valid?).to be false
    end
  end
end
