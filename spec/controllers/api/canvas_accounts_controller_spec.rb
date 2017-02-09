require "rails_helper"

RSpec.describe Api::CanvasAccountsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user_token = AuthToken.issue_token({ user_id: @user.id })

    @admin = FactoryGirl.create(:user)
    @admin.confirm
    @admin.add_to_role("administrator")
    @admin_token = AuthToken.issue_token({ user_id: @admin.id })

    @application_instance = FactoryGirl.create(:application_instance)
    allow(controller.request).to receive(:host).and_return("example.com")
    request.headers["Content-Type"] = "application/json"
  end

  context "not logged in" do
    describe "GET index" do
      it "returns unauthorized" do
        get :index, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as user" do
    before do
      request.headers["Authorization"] = @user_token
    end

    describe "GET index" do
      it "returns unauthorized" do
        get :index, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as admin" do
    before do
      request.headers["Authorization"] = @admin_token
      allow_any_instance_of(LMS::Canvas).to receive(:all_accounts).and_return([{}])
    end

    describe "GET index" do
      context "user is an admin that has authenticated with canvas" do
        it "renders all canvas accounts as json" do
          get :index, { oauth_consumer_key: @application_instance.lti_key }, format: :json
          expect(response).to have_http_status(200)
          accounts = JSON.parse(response.body)
          expect(accounts.count).to be > 0
        end
      end
    end
  end
end
