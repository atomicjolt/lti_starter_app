require "rails_helper"

RSpec.describe Admin::LtiInstallsController, type: :controller do
  before do
    @application = FactoryGirl.create(:lti_application)
  end

  context "not logged in" do
    describe "GET index" do
      it "redirects the user to the canvas authentication page" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end

  context "as user" do
    login_user

    describe "GET index" do
      it "redirects the user to the canvas authentication page" do
        get :index
        expect(response).to have_http_status(401)
      end
    end

  end

  context "as admin" do
    login_admin

    describe "GET index" do
      context "user has authenticated with canvas" do
        it "displays the admin lti tool" do
          get :index
          expect(response).to have_http_status(200)
        end
      end
    end

  end

end
