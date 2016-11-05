require "rails_helper"

RSpec.describe Admin::LtiInstallsController, type: :controller do

  before do
    @application = FactoryGirl.create(:lti_application)
  end

  context "not logged in" do
    describe "GET new" do
      it "redirects the user to the canvas authentication page" do
        get :new, {account_ids: [1]}
        expect(response).to have_http_status(302)
      end
    end
    describe "POST create" do
      it "redirects the user to the canvas authentication page" do
        post :create, { lti_install: {account_ids: ["43460000000000017"]}, lti_application_id: @application.id }
        expect(response).to have_http_status(302)
      end
    end
  end

  context "as user" do
    login_user

    describe "GET new" do
      it "redirects the user to the canvas authentication page" do
        get :new, {account_ids: [1]}
        expect(response).to have_http_status(401)
      end
    end

  end

  context "as admin" do
    login_admin

    before do
      authentication = FactoryGirl.create(:authentication, provider: 'canvas')
      @admin.authentications << authentication
    end

    describe "GET new" do
      context "user has authenticated with canvas" do
        before do
          @authentication = FactoryGirl.create(:authentication, user: @user, provider: 'canvas')
        end
        it "displays a form for the user to specify the accounts into which to install the LTI tool" do
          get :new
          expect(response).to have_http_status(200)
        end
      end
    end

    describe "POST create" do
      context "user has authenticated with canvas" do
        before do
          @authentication = FactoryGirl.create(:authentication, user: @user, provider: 'canvas')
        end
        # TODO have to figure out the admin side of things
        # it "Adds the LTI tool to the specified accounts" do
        #   post :create, { lti_install: {account_ids: ["43460000000000017"], course_ids: [""]}, lti_application_id: @application.id }
        #   expect(response).to have_http_status(200)
        # end
        # it "Adds the LTI tool to the specified courses" do
        #   post :create, { lti_install: {account_ids: [""], course_ids: ["43460000000000228"]}, lti_application_id: @application.id }
        #   expect(response).to have_http_status(200)
        # end
      end
      context "No accounts selected" do
        before do
          @authentication = FactoryGirl.create(:authentication, user: @user, provider: 'canvas')
        end
        it "Indicates the LTI tool was not installed" do
          post :create, { lti_install: {account_ids: [], course_ids: []}, lti_application_id: @application.id }
          expect(response).to have_http_status(200)
        end
      end
    end
  end

end
