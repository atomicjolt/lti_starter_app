require "rails_helper"

RSpec.describe LtiLaunchesController, type: :controller do
  render_views

  before do
    @app = FactoryGirl.create(:application_instance)
    allow(controller).to receive(:current_application_instance).and_return(@app)
  end

  describe "index" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end

    it "sets up the user and logs them in" do
      params = lti_params(
        @app.lti_key,
        @app.lti_secret,
        { "launch_url" => lti_launches_url, "roles" => "Learner" },
      )
      post :index, params: params
      expect(response).to have_http_status(200)
    end
  end

  describe "show" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end
    it "sets up the user, logs them and outputs the lti config to the client" do
      @lti_launch = FactoryGirl.create(:lti_launch)
      params = lti_params(
        @app.lti_key,
        @app.lti_secret,
        {
          "launch_url" => lti_launch_url(@lti_launch.token),
          "roles" => "Learner",
          "resource_link_id" => @lti_launch.token,
        },
      )
      post :show, params: { id: @lti_launch.token }.merge(params)
      expect(response).to have_http_status(200)
      expect(response.body).to include("lti_launch_config")
    end
  end
end
