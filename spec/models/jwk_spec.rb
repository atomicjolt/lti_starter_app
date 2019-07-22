require "rails_helper"

RSpec.describe Jwk, type: :model do
  before do
    application = FactoryBot.create(:application)
    @jwk = Jwk.create!(application: application)
  end
  describe "generate_keys" do
    it "generates keys when jwk is created" do
      expect(@jwk.pem).to be
      expect(@jwk.kid).to be
    end
  end

  describe "private_key" do
    it "outputs the private key for the jwk" do
      expect(@jwk.private_key).to be
    end
  end

  describe "to_json" do
    it "outputs json for the jwk" do
      expect(@jwk.to_json).to be
      expect(@jwk.to_json["alg"]).to eq(@jwk.alg)
      expect(@jwk.to_json["kid"]).to eq(@jwk.kid)
    end

    it "does not include the private key" do
      json = @jwk.to_json
      expect(json).not_to eq(@jwk.private_key.to_jwk)
    end
  end
end
