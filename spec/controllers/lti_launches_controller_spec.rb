require "rails_helper"

RSpec.describe LtiLaunchesController, type: :controller do
  render_views

  before do
    setup_application_instance
  end

  describe "index" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end

    it "sets up the user and logs them in" do
      params = lti_params(
        @application_instance.lti_key,
        @application_instance.lti_secret,
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
      context_id = SecureRandom.hex(15)
      @lti_launch = FactoryBot.create(:lti_launch, context_id: context_id)
      params = lti_params(
        @application_instance.lti_key,
        @application_instance.lti_secret,
        {
          "launch_url" => lti_launch_url(@lti_launch.token),
          "roles" => "Learner",
          "resource_link_id" => @lti_launch.token,
          "context_id" => context_id,
        },
      )
      post :show, params: { id: @lti_launch.token }.merge(params)
      expect(response).to have_http_status(200)
      expect(response.body).to include("lti_launch_config")
    end
  end
end
