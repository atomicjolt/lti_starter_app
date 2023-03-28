require "rails_helper"

RSpec.describe Api::LtiDeepLinkJwtController, type: :controller do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
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
        token = make_deep_link_jwt(@application_instance.id, @iss, @deployment_id, @context_id)
        request.headers["Authorization"] = token
        post :create, params: { type: "html" }, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        jwt = result["jwt"]
        expect(jwt).to be
      end
    end
  end

  describe "includes JwtToken" do
    it { expect(Api::LtiDeepLinkJwtController.ancestors.include?(JwtToken)).to eq(true) }
  end
end
