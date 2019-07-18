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

  describe "init" do
    before do
      @iss = "https://canvas.instructure.com"
      @application_instance.application.lti_installs.create!(
        iss: @iss,
        client_id: "43460000000000194",
        jwks_url: LtiAdvantage::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL,
        token_url: LtiAdvantage::Definitions::CANVAS_AUTH_TOKEN_URL,
        oidc_url: LtiAdvantage::Definitions::CANVAS_OIDC_URL,
      )
      allow(controller).to receive(:current_application).and_return(@application)
    end
    it "get a url that will be redirected to as part of the Open Id Connect process" do
      params = {
        "iss" => @iss,
        "login_hint" => "0340cde37624c04979a6c3fdd0afc2479f8405ad",
        "target_link_uri" => "https://helloworld.atomicjolt.xyz/lti_launches",
        "lti_message_hint" => "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2ZXJpZmllciI6IjI5M2NlNDI4MjM3ZTAyNTc5MDg3ZmVkOTU5M2EwYzFmMDVmYmNhOTZhNTU3YjQyYjNiOWJiZmIwNTE4MDM4NmQwYzA5NjdmM2FhZDdhYzczODc4Yjk1YjM4NWJmMDVhNDU4MTBmZGZmYzNiMThmZDA5ZWY5YjMyOTUzZjNiOWUwIiwiY2FudmFzX2RvbWFpbiI6ImF0b21pY2pvbHQuaW5zdHJ1Y3R1cmUuY29tIiwiY29udGV4dF90eXBlIjoiQ291cnNlIiwiY29udGV4dF9pZCI6NDM0NjAwMDAwMDAwMDMzMzQsImV4cCI6MTU2MzQwNzk5OX0.7y8ZqEz4zwGvaBUV8puXCIINxnCulRGRg58jExPAhTo",
        "controller" => "lti_launches",
        "action" => "init",
      }
      post :init, params: params
      expect(response).to have_http_status(302)
    end
  end
end
