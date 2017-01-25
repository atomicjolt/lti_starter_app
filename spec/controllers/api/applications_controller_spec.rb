require "rails_helper"

RSpec.describe Api::ApplicationsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user_token = AuthToken.issue_token({ user_id: @user.id })

    @application_instance = FactoryGirl.create(:application_instance)
    allow(controller.request).to receive(:host).and_return("example.com")
    request.headers["Content-Type"] = "application/json"
  end

  context "not logged in" do
    describe "GET index" do
      it "returns unauthorized" do
        get :index
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as user" do
    login_user

    before do
      request.headers["Authorization"] = @user_token
    end

    describe "GET index" do
      it "returns unauthorized" do
        get :index
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as admin" do
    login_admin

    before do
      request.headers["Authorization"] = @user_token
    end

    describe "GET index" do
      context "user is an admin that has authenticated with canvas" do
        it "renders all application instances as json" do
          get :index
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
