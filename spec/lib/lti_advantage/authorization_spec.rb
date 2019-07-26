require "rails_helper"

RSpec.describe LtiAdvantage::Authorization do
  before do
    setup_application_instance
    @platform_iss = "https://canvas.instructure.com"
    setup_canvas_lti_advantage(
      application_instance: @application_instance,
      iss: @platform_iss
    )
  end

  describe "application_instance_from_token" do
    it "finds an application instance using an jwt token" do
      inst = LtiAdvantage::Authorization.application_instance_from_token(@id_token)
      expect(inst).to eq(@application_instance)
    end
  end

  describe "validate_token" do
    it "validates the token provided by the platform" do
      token = LtiAdvantage::Authorization.validate_token(@application_instance, @id_token)
      expect(token).to be
      expect(token["iss"]).to eq @iss
    end
  end

  describe "client_assertion" do
    it "generates a token that can be passed to the platform to request and access token" do
      jwt = LtiAdvantage::Authorization.client_assertion(@application_instance, @platform_iss)
      expect(jwt).to be
      decoded_token = JWT.decode(jwt, nil, false)[0]
      expect(decoded_token["iss"]).to eq @application_instance.lti_key
    end
  end

  describe "request_token" do
    it "requests an access token from the platform" do
      decoded_token = LtiAdvantage::Authorization.validate_token(@application_instance, @id_token)
      auth = LtiAdvantage::Authorization.request_token(@application_instance, decoded_token)
      expect(auth).to be
    end
  end
end