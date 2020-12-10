require "rails_helper"

RSpec.describe Api::CanvasProxyController, type: :controller do
  before do
    setup_lti_users
    setup_application_instance
  end

  describe "proxy without authorization" do
    describe "GET" do
      it "should return an unauthorized" do
        get :proxy, params: { lms_proxy_call_type: "foo" }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context "as student" do
    describe "proxy" do
      before do
        allow(Application).to receive(:find_by).with(:lti_key).and_return(@application_instance)
        request.headers["Authorization"] = @student_token
        allow(controller.request).to receive(:host).and_return("example.com")
      end

      describe "GET" do
        it "returns forbidden" do
          type = "LIST_ACCOUNTS"
          get :proxy, params: { lms_proxy_call_type: type, lti_key: @application_instance.lti_key }, format: :json
          expect(response).to have_http_status(:forbidden)
        end
        it "returns forbidden" do
          type = "LIST_YOUR_COURSES"
          get :proxy, params: { lms_proxy_call_type: type, lti_key: @application_instance.lti_key, account_id: 1 }, format: :json
          expect(response).to have_http_status(:forbidden)
        end
        it "returns forbidden" do
          type = "LIST_YOUR_COURSES"
          get :proxy,
              params: {
                lms_proxy_call_type: type,
                lti_key: @application_instance.lti_key,
                account_id: 1,
                include: [1, 2],
                per_page: 100,
              },
              format: :json
          expect(response).to have_http_status(:forbidden)
        end
      end

      describe "POST" do
        it "returns forbidden" do
          type = "CREATE_NEW_SUB_ACCOUNT"
          payload = {
            account: { name: "Canvas Demo Courses" },
          }.to_json
          post :proxy,
               body: payload,
               params: {
                 lms_proxy_call_type: type,
                 lti_key: @application_instance.lti_key,
                 account_id: 1,
               },
               format: :json
          expect(response).to have_http_status(:forbidden)
        end
      end

      describe "PUT" do
        it "returns forbidden" do
          type = "UPDATE_ACCOUNT"
          payload = {
            name: "Canvas Demo Courses",
          }.to_json
          put :proxy,
              body: payload,
              params: {
                lms_proxy_call_type: type,
                lti_key: @application_instance.lti_key,
                id: 1,
              },
              format: :json
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  context "as admin" do
    # This functionality lives in application_controller.rb but we need
    # a real controller to test it
    describe "rescue from LMS::Canvas::RefreshTokenRequired" do
      before do
        request.headers["Authorization"] = @admin_token
        allow(controller.request).to receive(:host).and_return("example.com")
        def controller.proxy
          @auth = FactoryBot.create(:authentication)
          @auth_id = @auth.id
          raise LMS::Canvas::RefreshTokenRequired.new("", nil, @auth)
        end
      end
      context "application instance allows user token" do
        before do
          allow(Application).to receive(:find_by).with(:lti_key).and_return(@application_instance)
        end
        it "deletes the authentication and returns a status unauthorized" do
          type = "LIST_ACCOUNTS"
          get :proxy, params: { lms_proxy_call_type: type, lti_key: @application_instance.lti_key }, format: :json
          expect(response).to have_http_status(:unauthorized)
          auth = Authentication.find_by(id: @auth_id)
          expect(auth).to be_nil
          expect(response.body).to eq("{\"message\":\"Canvas API Token has expired.\",\"canvas_authorization_required\":true}")
        end
      end
      context "application instance doesn't allow user token" do
        before do
          @application_instance.application.update(
            canvas_api_permissions: @canvas_api_permissions,
            oauth_precedence: "global,application_instance,course",
          )
          allow(Application).to receive(:find_by).with(:lti_key).and_return(@application_instance)
        end
        it "deletes the authentication and returns a status forbidden" do
          type = "LIST_ACCOUNTS"
          get :proxy, params: { lms_proxy_call_type: type, lti_key: @application_instance.lti_key }, format: :json
          expect(response).to have_http_status(:unauthorized)
          auth = Authentication.find_by(id: @auth_id)
          expect(auth).to be_nil
          expect(response.body).to eq("{\"message\":\"Canvas API Token has expired.\"}")
        end
      end
    end

    describe "proxy" do
      before do
        allow(Application).to receive(:find_by).with(:lti_key).and_return(@application_instance)
        request.headers["Authorization"] = @admin_token
        allow(controller.request).to receive(:host).and_return("example.com")
      end

      describe "GET" do
        it "should successfully call the canvas api" do
          type = "LIST_ACCOUNTS"
          get :proxy, params: { lms_proxy_call_type: type, lti_key: @application_instance.lti_key }, format: :json
          expect(response).to have_http_status(:success)
        end
        it "should successfully call the canvas api to generate a url to get courses" do
          type = "LIST_YOUR_COURSES"
          get :proxy, params: { lms_proxy_call_type: type, lti_key: @application_instance.lti_key, account_id: 1 }, format: :json
          expect(response).to have_http_status(:success)
        end
        it "should successfully call the canvas api to generate a url to get courses with extra params" do
          type = "LIST_YOUR_COURSES"
          get :proxy,
              params: {
                lms_proxy_call_type: type,
                lti_key: @application_instance.lti_key,
                account_id: 1,
                include: [1, 2],
                per_page: 100,
              },
              format: :json
          expect(response).to have_http_status(:success)
        end
      end

      describe "POST" do
        it "successfully posts to the canvas api" do
          type = "CREATE_NEW_SUB_ACCOUNT"
          payload = {
            account: { name: "Canvas Demo Courses" },
          }.to_json
          post :proxy,
               body: payload,
               params: {
                 lms_proxy_call_type: type,
                 lti_key: @application_instance.lti_key,
                 account_id: 1,
               },
               format: :json
          expect(JSON.parse(response.body)["name"]).to eq("Canvas Demo Courses")
        end
      end

      describe "PUT" do
        it "successfully puts to the canvas api" do
          type = "UPDATE_ACCOUNT"
          payload = {
            name: "Canvas Demo Courses",
          }.to_json
          put :proxy,
              body: payload,
              params: {
                lms_proxy_call_type: type,
                lti_key: @application_instance.lti_key,
                id: 1,
              },
              format: :json
          expect(JSON.parse(response.body)["name"]).to eq("Canvas Demo Courses")
        end
      end
    end
  end
end
