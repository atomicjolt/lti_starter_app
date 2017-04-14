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

    describe "POST create" do
      it "returns unauthorized" do
        post :create, params: { site: FactoryGirl.attributes_for(:site) }, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "PUT update" do
      it "returns unauthorized" do
        site = FactoryGirl.create(:site)
        put :update, params: { id: site.id, site: site }, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "DELETE destroy" do
      it "returns unauthorized" do
        site = FactoryGirl.create(:site)
        delete :destroy, params: { id: site.id, site: site }, format: :json
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

    describe "POST create" do
      it "creates a new site" do
        post :create, params: { site: FactoryGirl.attributes_for(:site) }, format: :json
        expect(response).to be_success
      end
    end

    describe "PUT update" do
      it "updates the site" do
        site = FactoryGirl.create(:site)
        put :update, params: { id: site.id, site: { oauth_key: "12345" } }, format: :json
        expect(response).to be_success
        updated = JSON.parse(response.body)
        expect(updated["oauth_key"]).to eq("12345")
      end
    end

    describe "DELETE destroy" do
      it "returns unauthorized" do
        site = FactoryGirl.create(:site)
        delete :destroy, params: { id: site.id }, format: :json
        expect(response).to be_success
      end
    end
  end
end
