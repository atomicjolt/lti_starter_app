require "rails_helper"

RSpec.describe Api::LtiDeepLinkJwtController, type: :controller do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
    setup_lti_advantage_users
  end

  context "without jwt token" do
    it "should not be authorized" do
      post :create, params: { type: "html" }, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with jwt token" do
    describe "POST create" do
      it "generates a jwt that contains an html content item" do
        request.headers["Authorization"] = @student_token
        post :create, params: { type: "html" }, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        jwt = result["jwt"]
        expect(jwt).to be
      end
    end
  end

  describe "includes JwtToken" do
    it { expect(Api::LtiDeepLinkJwtController.ancestors.include?(Concerns::JwtToken)).to eq(true) }
  end
end
