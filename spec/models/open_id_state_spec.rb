require "rails_helper"

RSpec.describe OpenIdState, type: :model do
  describe "valid?" do
    it "is true when nonce is unique" do
      nonce = SecureRandom.hex(64)
      open_id_state = create(:open_id_state, nonce: nonce)
      expect(open_id_state.valid?).to be true
    end

    it "is false for duplicate nonce" do
      nonce = SecureRandom.hex(64)
      create(:open_id_state, nonce: nonce)
      open_id_state = build(:open_id_state, nonce: nonce)
      expect(open_id_state.valid?(nonce)).to be false
    end

    it "is false when nonce is missing" do
      nonce = nil
      open_id_state = build(:open_id_state, nonce: nonce)
      expect(open_id_state.valid?).to be false
    end
  end
end
