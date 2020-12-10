require "rails_helper"

RSpec.describe Api::ApplicationsController, type: :controller do
  before do
    setup_lti_users
    setup_application_instance
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
          applications = JSON.parse(response.body)
          expect(applications.count).to be > 0
          expect(applications[0]["application_instances_count"]).to be 1
        end
      end
    end

    describe "PUT update" do
      it "Updates the application instance" do
        put :update,
            params: {
              id: @application.id,
              application: {
                name: "bfcoder",
              },
            },
            format: :json
        expect(response).to have_http_status(204)
      end
    end
  end
end
