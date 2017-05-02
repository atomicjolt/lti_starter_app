require "rails_helper"

RSpec.describe Api::LtiLaunchesController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user_token = AuthToken.issue_token({ user_id: @user.id })

    @application = FactoryGirl.create(:application)
    @application_instance = FactoryGirl.create(:application_instance, application: @application)
  end

  context "no jwt" do
    describe "POST create" do
      it "returns unauthorized" do
        post :create, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as user" do
    before do
      request.headers["Authorization"] = @user_token
    end

    describe "POST create" do
      it "creates a new lti launch and return the result" do
        post :create, params: { lti_launch: FactoryGirl.attributes_for(:lti_launch) }, format: :json
        expect(response).to be_success
      end

      it "sets the lti launch with the correct config" do
        post :create, params: { lti_launch: { config: { test: "value" }.to_json } }, format: :json
        json = JSON.parse(response.body)
        config = JSON.parse(json["config"])
        expect(config["test"]).to eq("value")
      end
    end
  end
end
