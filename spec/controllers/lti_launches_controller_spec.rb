require "rails_helper"

RSpec.describe LtiLaunchesController, type: :controller do

  before do
    @app = FactoryGirl.create(:lti_application_instance)
    allow(controller).to receive(:current_lti_application_instance).and_return(@app)
  end

  describe "index" do

    before do
      request.env['CONTENT_TYPE'] = "application/x-www-form-urlencoded"
    end

    it "sets up the user, logs them in and redirects" do
      params = lti_params(@app.lti_key, @app.lti_secret, {"launch_url" => lti_launches_url, "roles" => "Learner"})
      post :index, params
      expect(response).to have_http_status(200)
    end

  end

end