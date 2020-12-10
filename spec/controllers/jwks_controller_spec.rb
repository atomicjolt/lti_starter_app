require "rails_helper"

RSpec.describe JwksController, type: :controller do
  before do
    setup_application_instance
    allow(controller).to receive(:current_application).and_return(@application)
  end

  describe "index" do
    it "outputs the jwt public keys for the current application" do
      get :index, format: :json
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to eq({ "keys" => @application.jwks.map(&:to_json) })
      jwk = @application.jwks.first.private_key.to_jwk
      expect(response.body.include?(jwk["d"])).to be false
      expect(response.body.include?(jwk["p"])).to be false
      expect(response.body.include?(jwk["q"])).to be false
      expect(response.body.include?(jwk["dp"])).to be false
      expect(response.body.include?(jwk["qi"])).to be false
    end
  end
end
