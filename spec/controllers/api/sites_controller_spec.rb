require "rails_helper"

RSpec.describe Api::SitesController, type: :controller do
  before do
    setup_lti_users
    setup_application_and_instance
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
      request.headers["Authorization"] = @student_token
    end

    describe "GET index" do
      it "returns unauthorized" do
        get :index, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "POST create" do
      it "returns unauthorized" do
        post :create, params: { site: FactoryBot.attributes_for(:site) }, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "PUT update" do
      it "returns unauthorized" do
        site = FactoryBot.create(:site)
        put :update, params: { id: site.id, site: site }, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "DELETE destroy" do
      it "returns unauthorized" do
        site = FactoryBot.create(:site)
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
        post :create, params: { site: FactoryBot.attributes_for(:site) }, format: :json
        expect(response).to be_success
      end
    end

    describe "PUT update" do
      it "updates the site" do
        site = FactoryBot.create(:site)
        put :update, params: { id: site.id, site: { oauth_key: "12345" } }, format: :json
        expect(response).to be_success
        updated = JSON.parse(response.body)
        expect(updated["oauth_key"]).to eq("12345")
      end
    end

    describe "DELETE destroy" do
      it "returns unauthorized" do
        site = FactoryBot.create(:site)
        delete :destroy, params: { id: site.id }, format: :json
        expect(response).to be_success
      end
    end
  end
end
