require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    setup_application_instance
    allow(controller).to receive(:current_application).and_return(@application)
  end

  controller do
    include Concerns::OpenIdConnectSupport

    skip_before_action :verify_authenticity_token

    def index
      nonce = SecureRandom.hex(10)
      state = AuthToken.issue_token({
                                      state_nonce: nonce,
                                      params: params.as_json,
                                    })
      url = build_response(state, params, nonce)
      request.cookies[:state] = state
      render plain: "Url: #{url}"
    end
  end

  describe "open id connect initialization" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
      setup_canvas_lti_advantage(application_instance: @application_instance)
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
      post :index, params: params
      expect(response).to have_http_status(200)
      expect(response.body).to include("Url:")
    end
  end
end