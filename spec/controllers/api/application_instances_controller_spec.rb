require "rails_helper"

RSpec.describe Api::ApplicationInstancesController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user_token = AuthToken.issue_token({ user_id: @user.id })

    @admin = FactoryGirl.create(:user)
    @admin.confirm
    @admin.add_to_role("administrator")
    @admin_token = AuthToken.issue_token({ user_id: @admin.id })

    @application_instance = FactoryGirl.create(:application_instance)
    @application = @application_instance.application
  end

  context "no jwt" do
    describe "GET index" do
      it "returns unauthorized" do
        get :index, params: { application_id: @application.id }, format: :json
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
        get :index, params: { application_id: @application.id }, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as admin" do
    before do
      request.headers["Authorization"] = @admin_token
    end

    describe "GET index" do
      it "renders all application instances as json" do
        get :index, params: { application_id: @application.id }, format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "GET create" do
      it "creates a new application instances and returns json" do
        site = FactoryGirl.create(:site)
        attrs = {
          lti_key: "test-key",
          site_id: site.id,
        }
        post :create,
             params: {
               application_id: @application.id,
               application_instance: attrs,
             },
             format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "PUT update" do
      it "Updates the application instance" do
        put :update,
            params: {
              application_id: @application.id,
              id: @application_instance.id,
              application_instance: {
                lti_secret: "12345",
              },
            },
            format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "DEL destroy" do
      it "Deletes the application instance" do
        delete :destroy,
               params: {
                 application_id: @application.id,
                 id: @application_instance.id,
               },
               format: :json
        expect(response).to have_http_status(200)
      end
    end
  end
end
