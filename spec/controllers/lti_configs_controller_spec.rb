require "rails_helper"

RSpec.describe LtiConfigsController, type: :controller do
  before do
    setup_application_instance
    allow(controller).to receive(:current_application).and_return(@application)
  end

  describe "show" do
    it "outputs the lti advantage configuration for the current application" do
      post :show, format: :json
      expect(response).to have_http_status(200)
      expect(response.body).to eq(@application.lti_advantage_config_json)
    end
  end
end