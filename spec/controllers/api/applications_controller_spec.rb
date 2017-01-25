require "rails_helper"

RSpec.describe Api::ApplicationsController, type: :controller do
  before do
    @application_instance = FactoryGirl.create(:application_instance)
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
      context "user is and admin that has authenticated with canvas" do
        it "renders all application instances as json" do
          get :index
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
