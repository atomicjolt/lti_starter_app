require "rails_helper"

RSpec.describe Api::SitesController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user_token = AuthToken.issue_token({ user_id: @user.id })

    @admin = FactoryGirl.create(:user)
    @admin.confirm
    @admin.add_to_role("administrator")
    @admin_token = AuthToken.issue_token({ user_id: @admin.id })

    @application = FactoryGirl.create(:application)
    @application_instance = FactoryGirl.create(:application_instance, application: @application)
  end

  context "no jwt" do
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
    end

    describe "GET index" do
      context "user is an admin that has authenticated with canvas" do
        it "renders all canvas accounts as json" do
          get :index, format: :json
          expect(response).to have_http_status(200)
          sites = JSON.parse(response.body)
          expect(sites.count).to be > 0
          expect(sites[0]["url"]).to eq @application_instance.site.url
        end
      end
    end
  end
end
