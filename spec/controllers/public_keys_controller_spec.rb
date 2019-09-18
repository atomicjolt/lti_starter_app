require "rails_helper"

RSpec.describe PublicKeysController, type: :controller do
  before do
    setup_application_instance
    allow(controller).to receive(:current_application).and_return(@application)
  end

  describe "index" do
    it "outputs the jwt public keys for the current application" do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to eq(@application.current_jwk.private_key.public_key.to_pem)
    end
  end
end
