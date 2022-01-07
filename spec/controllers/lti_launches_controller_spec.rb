require "rails_helper"

RSpec.describe LtiLaunchesController, type: :controller do
  before do
    setup_application_instance
  end

  describe "index" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end

    context "lti launch" do
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

    context "lti advantage launch" do
      before do
        setup_canvas_lti_advantage(application_instance: @application_instance)
        allow(controller).to receive(:current_application).and_return(@application)
      end

      it "does an lti advantage launch " do
        post :index, params: @params
        expect(response).to have_http_status(200)
      end

      context "when launching an LtiLaunch that doesn't have a resource_link_id" do
        it "updates the LtiLaunch with the resource_link_id" do
          resource_link_id = SecureRandom.hex

          setup_canvas_lti_advantage(
            application_instance: @application_instance,
            resource_link_id: resource_link_id,
          )

          lti_launch = FactoryBot.create(:lti_launch, context_id: @context_id)

          post :index, params: @params.merge(lti_launch_token: lti_launch.token)

          expect(lti_launch.reload.resource_link_id).to eq(resource_link_id)
        end
      end
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

    context "when the LtiLaunch doesn't have a resource_link_id" do
      it "updates the LtiLaunch with the resource_link_id" do
        context_id = SecureRandom.hex
        resource_link_id = SecureRandom.hex
        lti_launch = FactoryBot.create(:lti_launch, context_id: context_id)
        params = lti_params(
          @application_instance.lti_key,
          @application_instance.lti_secret,
          {
            "launch_url" => lti_launch_url(lti_launch.token),
            "context_id" => context_id,
            "resource_link_id" => resource_link_id,
          },
        )

        post :show, params: { id: lti_launch.token }.merge(params)

        expect(lti_launch.reload.resource_link_id).to eq(resource_link_id)
      end
    end
  end

  describe "init" do
    before do
      setup_canvas_lti_advantage(application_instance: @application_instance)
      allow(controller).to receive(:current_application).and_return(@application)
    end
    it "get a url that will be redirected to as part of the Open Id Connect process" do
      params = {
        "iss" => @iss,
        "client_id" => @client_id,
        "login_hint" => "0340cde37624c04979a6c3fdd0afc2479f8405ad",
        "target_link_uri" => "https://hellolti.atomicjolt.xyz/lti_launches",
        "lti_message_hint" => "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2ZXJpZmllciI6IjI5M2NlNDI4MjM3ZTAyNTc5MDg3ZmVkOTU5M2EwYzFmMDVmYmNhOTZhNTU3YjQyYjNiOWJiZmIwNTE4MDM4NmQwYzA5NjdmM2FhZDdhYzczODc4Yjk1YjM4NWJmMDVhNDU4MTBmZGZmYzNiMThmZDA5ZWY5YjMyOTUzZjNiOWUwIiwiY2FudmFzX2RvbWFpbiI6ImF0b21pY2pvbHQuaW5zdHJ1Y3R1cmUuY29tIiwiY29udGV4dF90eXBlIjoiQ291cnNlIiwiY29udGV4dF9pZCI6NDM0NjAwMDAwMDAwMDMzMzQsImV4cCI6MTU2MzQwNzk5OX0.7y8ZqEz4zwGvaBUV8puXCIINxnCulRGRg58jExPAhTo",
        "controller" => "lti_launches",
        "action" => "init",
      }
      post :init, params: params
      expect(response).to have_http_status(302)
    end
  end
end
