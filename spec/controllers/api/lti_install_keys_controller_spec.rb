require "rails_helper"

RSpec.describe Api::LtiInstallKeysController, type: :controller do
  before do
    setup_lti_users
    setup_application_instance
    @lti_install = FactoryBot.create(
      :lti_install,
      application: @application,
    )
  end

  context "when no jwt" do
    describe "GET index" do
      it "returns unauthorized" do
        get :index, params: { application_id: @application.id }, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "with a user" do
    before do
      request.headers["Authorization"] = @user_token
    end

    describe "GET index" do
      it "returns unauthorized" do
        get :index, params: { application_id: @application.id }, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "GET show" do
      it "returns unauthorized" do
        get :show, params: { id: @lti_install.id, application_id: @application.id }, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "with an admin" do
    before do
      request.headers["Authorization"] = @admin_token
    end

    describe "GET index" do
      it "renders all lti install keys as json" do
        get :index, params: { application_id: @application.id }, format: :json
        expect(response).to have_http_status(200)
      end

      it "renders all lti install keys by oldest" do
        app = create(:application)
        lti_install1 = create(:lti_install, application: app, created_at: 1.week.ago)
        lti_install2 = create(:lti_install, application: app, created_at: 2.weeks.ago)
        lti_install3 = create(:lti_install, application: app, created_at: 1.day.ago)
        lti_install4 = create(:lti_install, application: app, created_at: 3.days.ago)
        params = {
          application_id: app.id,
          column: :created_at,
          direction: :asc,
        }
        get :index, params: params, format: :json
        result = JSON.parse(response.body)
        expected_key_ids = [lti_install2.id, lti_install1.id, lti_install4.id, lti_install3.id]
        returned_key_ids = result["lti_install_keys"].map { |lti_install| lti_install["id"] }
        expect(returned_key_ids).to eq(expected_key_ids)
      end

      it "renders all lti install keys by client_id" do
        app = create(:application)
        lti_install1 = create(:lti_install, application: app, client_id: "c")
        lti_install2 = create(:lti_install, application: app, client_id: "g")
        lti_install3 = create(:lti_install, application: app, client_id: "a")
        lti_install4 = create(:lti_install, application: app, client_id: "z")
        params = {
          application_id: app.id,
          column: :client_id,
          direction: :asc,
        }
        get :index, params: params, format: :json
        result = JSON.parse(response.body)
        expected_key_ids = [lti_install3.id, lti_install1.id, lti_install2.id, lti_install4.id]
        returned_key_ids = result["lti_install_keys"].map { |lti_install| lti_install["id"] }
        expect(returned_key_ids).to eq(expected_key_ids)
      end
    end

    describe "GET show" do
      it "renders specific lti install keys as json" do
        get :show, params: { id: @lti_install.id, application_id: @application.id }, format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "POST create" do
      it "creates a new lti install keys and returns json" do
        attrs = {
          client_id: FactoryBot.generate(:lti_key),
        }
        params = {
          application_id: @application.id,
          lti_install: attrs,
        }
        post :create, params: params, format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "PUT update" do
      it "Updates the lti install key" do
        params = {
          application_id: @application.id,
          id: @lti_install.id,
          lti_install: {
            client_id: "12345",
          },
        }
        put :update, params: params, format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "DEL destroy" do
      before do
        @params = {
          application_id: @application.id,
          id: @lti_install.id,
        }
      end

      it "Deletes the lti install" do
        delete :destroy, params: @params, format: :json
        lti_install = LtiInstall.find_by(id: @lti_install.id)
        expect(lti_install).to be(nil)
      end
    end
  end
end
