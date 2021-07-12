require "rails_helper"

RSpec.describe Api::ApplicationInstancesController, type: :controller do
  before do
    setup_lti_users
    setup_application_instance
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

    describe "GET show" do
      it "returns unauthorized" do
        get :show, params: { id: @application_instance.id, application_id: @application.id }, format: :json
        expect(response).to have_http_status(401)
      end
    end

    describe "GET check_auth" do
      it "returns unauthorized" do
        authentication = FactoryBot.create(:authentication)
        get :check_auth, params: {
          application_id: @application.id,
          id: @application_instance.id,
          authentication_id: authentication.id,
        }, format: :json
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

      it "renders all application instances by oldest" do
        app = create(:application)
        ai1 = create(:application_instance, application: app, created_at: 1.week.ago)
        ai2 = create(:application_instance, application: app, created_at: 2.week.ago)
        ai3 = create(:application_instance, application: app, created_at: 1.day.ago)
        ai4 = create(:application_instance, application: app, created_at: 3.days.ago)
        params = {
          application_id: app.id,
          column: :created_at,
          direction: :asc,
        }
        get :index, params: params, format: :json
        result = JSON.parse(response.body)
        expected_instance_ids = [ai2.id, ai1.id, ai4.id, ai3.id]
        returned_instance_ids = result["application_instances"].map { |ai| ai["id"] }
        expect(returned_instance_ids).to eq(expected_instance_ids)
      end

      it "renders all application instances by lti_key" do
        app = create(:application)
        ai1 = create(:application_instance, application: app, nickname: "banana")
        ai2 = create(:application_instance, application: app, nickname: "Cat")
        ai3 = create(:application_instance, application: app, nickname: "Apple")
        ai4 = create(:application_instance, application: app, nickname: "dog")
        params = {
          application_id: app.id,
          column: :nickname,
          direction: :asc,
        }
        get :index, params: params, format: :json
        result = JSON.parse(response.body)
        expected_instance_ids = [ai3.nickname, ai1.nickname, ai2.nickname, ai4.nickname]
        returned_instance_ids = result["application_instances"].map { |ai| ai["nickname"] }
        expect(returned_instance_ids).to eq(expected_instance_ids)
      end
    end

    describe "GET show" do
      it "renders specific application instances as json" do
        Apartment::Tenant.switch(@application_instance.tenant) do
          FactoryBot.create(:authentication, application_instance: @application_instance)
        end
        get :show, params: { id: @application_instance.id, application_id: @application.id }, format: :json
        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json["authentications"].length).to eq(1)
      end
    end

    describe "GET check_auth" do
      it "renders all accounts the auth object has access to" do
        authentication = Apartment::Tenant.switch(@application_instance.tenant) do
          FactoryBot.create(:authentication, application_instance: @application_instance)
        end
        get :check_auth, params: {
          application_id: @application.id,
          id: @application_instance.id,
          authentication_id: authentication.id,
        }, format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "POST create" do
      it "creates a new application instances and returns json" do
        site = FactoryBot.create(:site)
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
      it "Updates the application instance config_xml" do
        put :update,
            params: {
              application_id: @application.id,
              id: @application_instance.id,
              application_instance: {
                lti_secret: "12345",
                lti_config: {
                  title: "Nucleus",
                  privacy_level: "anonymous",
                  icon: "oauth_icon.png",
                  course_navigation: {
                    text: "Nucleus",
                    visibility: "public",
                  },
                },
              },
            },
            format: :json
        expect(response).to have_http_status(200)
        result = JSON.parse(response.body)
        xml = result["lti_config_xml"]
        expect(xml).to include('<lticm:property name="privacy_level">anonymous</lticm:property>')
      end
    end

    describe "DEL destroy" do
      before do
        @params = {
          application_id: @application.id,
          id: @application_instance.id,
        }
      end

      it "Deletes the application instance" do
        delete :destroy, params: @params, format: :json
        ai = ApplicationInstance.find_by(id: @application_instance.id)
        expect(ai).to be(nil)
      end

      it "Deletes the tenant" do
        delete :destroy, params: @params, format: :json
        expect do
          Apartment::Tenant.switch!(@application_instance.tenant)
        end.to raise_error(Apartment::TenantNotFound)
      end

      it "Deletes the request statistics" do
        tenant = @application_instance.tenant
        FactoryBot.create(:request_statistic, tenant: tenant)
        FactoryBot.create(:request_user_statistic, tenant: tenant)
        delete :destroy, params: @params, format: :json
        request_statistics_count = RequestStatistic.where(tenant: tenant).count
        request_user_statistics_count = RequestUserStatistic.where(tenant: tenant).count
        expect(request_statistics_count).to eq(0)
        expect(request_user_statistics_count).to eq(0)
      end
    end
  end
end
