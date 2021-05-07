require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    setup_application_instance
  end

  describe "valid application instance api token" do
    before do
      admin_api_permissions = {
        default: [
          "administrator", # Internal (non-LTI) role
          "urn:lti:sysrole:ims/lis/SysAdmin",
          "urn:lti:sysrole:ims/lis/Administrator",
        ],
        common: [],
        LIST_ACCOUNTS: [],
      }
      @application_instance.application.update(canvas_api_permissions: admin_api_permissions)

      @user = FactoryBot.create(:user)
      allow(controller).to receive(:current_user).and_return(@user)

      @user.add_to_role("urn:lti:role:ims/lis/Learner")
      @user.save!
      @user_token = AuthToken.issue_token({ user_id: @user.id })
      @user_token_header = "Bearer #{@user_token}"
      request.headers["Authorization"] = @user_token_header
    end

    controller do
      include CanvasSupport

      before_action :protect_canvas_api

      def index
        result = canvas_api.proxy(params[:lms_proxy_call_type], params.to_unsafe_h, request.body.read)
        response.status = result.code

        render plain: result.body
      end
    end

    it "provides access to the canvas api for an administrator" do
      admin = FactoryBot.create(:user)
      admin.add_to_role("administrator")
      admin.save!
      allow(controller).to receive(:current_user).and_return(admin)
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS",
      }, format: :json
      expect(response).to have_http_status(:success)
    end

    it "prohibits a user from accessing the canvas api" do
      user = FactoryBot.create(:user)
      user_token = AuthToken.issue_token({ user_id: user.id })
      user_token_header = "Bearer #{user_token}"
      allow(controller).to receive(:current_user).and_return(user)
      request.headers["Authorization"] = user_token_header

      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS",
      }, format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it "doesn't allow access to forbidden API endpoints" do
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS_FOR_COURSE_ADMINS",
      }, format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it "doesn't allow access to forbidden API endpoints when application instances doesn't have an API token" do
      @application_instance.update(canvas_token: nil)
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS_FOR_COURSE_ADMINS",
      }, format: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "valid user api token" do
    before do
      @user = FactoryBot.create(:user)
      allow(controller).to receive(:current_user).and_return(@user)

      canvas_api_permissions = {
        default: [
          "administrator", # Internal (non-LTI) role
          "urn:lti:sysrole:ims/lis/SysAdmin",
          "urn:lti:sysrole:ims/lis/Administrator",
          "urn:lti:role:ims/lis/Learner",
        ],
        common: [],
        LIST_ACCOUNTS: [],
      }
      @application_instance.application.update(canvas_api_permissions: canvas_api_permissions)
      @application_instance.update(canvas_token: nil)

      @authentication = FactoryBot.create(
        :authentication,
        provider_url: UrlHelper.scheme_host_port(@application_instance.site.url),
        refresh_token: "asdf",
      )
      @user.authentications << @authentication

      @user.add_to_role("urn:lti:role:ims/lis/Learner")
      @user.save!

      @user_token = AuthToken.issue_token({ user_id: @user.id })
      @user_token_header = "Bearer #{@user_token}"
      request.headers["Authorization"] = @user_token_header
    end

    describe "use application_instance.auth_precedence" do
      controller do
        include CanvasSupport

        before_action :protect_canvas_api

        def index
          result = canvas_api.proxy(params[:lms_proxy_call_type], params.to_unsafe_h, request.body.read)
          response.status = result.code

          render plain: result.body
        end
      end

      it "provides access to the canvas api" do
        get :index, params: { lti_key: @application_instance.lti_key, lms_proxy_call_type: "LIST_ACCOUNTS" }, format: :json
        expect(response).to have_http_status(:success)
      end
    end

    describe "prefer user authentication" do
      before do
        canvas_api_permissions = {
          default: [
            "administrator", # Internal (non-LTI) role
            "urn:lti:sysrole:ims/lis/SysAdmin",
            "urn:lti:sysrole:ims/lis/Administrator",
            "urn:lti:role:ims/lis/Learner",
          ],
          common: [],
          LIST_ACCOUNTS: [],
        }

        @application_instance.application.update(
          canvas_api_permissions: canvas_api_permissions,
          oauth_precedence: "global,application_instance,course,user",
        )
        @application_instance.update(canvas_token: "afaketoken")

        @authentication = FactoryBot.create(
          :authentication,
          provider_url: UrlHelper.scheme_host_port(@application_instance.site.url),
          refresh_token: "qwerty",
        )
        @user.authentications << @authentication
        @application_instance.authentications << @authentication
        @application_instance.save!
      end
      controller do
        include CanvasSupport

        before_action :protect_canvas_api

        def index
          api = canvas_api(prefer_user: true)
          render json: api
        end
      end

      it "provides access to the canvas api using the user's authentication" do
        get :index, params: { lti_key: @application_instance.lti_key, lms_proxy_call_type: "LIST_ACCOUNTS" }, format: :json
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(@user.authentications.pluck(:id).include?(json["authentication"]["id"])).to be true
      end
    end
  end

  describe "user with canvas_oauth_user" do
    before do
      @user = FactoryBot.create(:user)
      allow(controller).to receive(:current_user).and_return(@user)

      canvas_api_permissions = {
        default: [],
        common: [],
        LIST_ACCOUNTS: ["canvas_oauth_user"],
      }
      @application_instance.application.update(canvas_api_permissions: canvas_api_permissions)
      @application_instance.update(canvas_token: nil)

      @authentication = FactoryBot.create(
        :authentication,
        provider_url: UrlHelper.scheme_host_port(@application_instance.site.url),
        refresh_token: "asdf",
      )

      @user.add_to_role("canvas_oauth_user")
      @user.save!

      @user_token = AuthToken.issue_token({ user_id: @user.id })
      @user_token_header = "Bearer #{@user_token}"
      request.headers["Authorization"] = @user_token_header
    end

    controller do
      include CanvasSupport

      before_action :protect_canvas_api

      def index
        result = canvas_api.proxy(params[:lms_proxy_call_type], params.to_unsafe_h, request.body.read)
        response.status = result.code
        render plain: result.body
      end
    end

    it "provides access to the canvas api using the user's token" do
      @user.authentications << @authentication
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS",
      }, format: :json
      expect(response).to have_http_status(:success)
    end

    it "denies access to the canvas api when user doesn't have a token even if application instance does have a token" do
      @application.oauth_precedence = "user"
      @application.save!
      @application_instance.authentications << @authentication
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS",
      }, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "check context" do
    before do
      @user = FactoryBot.create(:user)
      allow(controller).to receive(:current_user).and_return(@user)

      canvas_api_permissions = {
        default: [
          "urn:lti:role:ims/lis/Instructor",
        ],
        common: [],
        LIST_ACCOUNTS: [],
      }

      @application_instance.application.update(canvas_api_permissions: canvas_api_permissions)
      @application_instance.update(canvas_token: nil)

      @authentication = FactoryBot.create(
        :authentication,
        provider_url: UrlHelper.scheme_host_port(@application_instance.site.url),
        refresh_token: "asdf",
      )
      @user.authentications << @authentication

      @context_id = "123456"
      @user.add_to_role("urn:lti:role:ims/lis/Instructor", @context_id)
      @user.save!
      @user_token = AuthToken.issue_token({ user_id: @user.id, context_id: @context_id })
      @user_token_header = "Bearer #{@user_token}"
      request.headers["Authorization"] = @user_token_header
    end
    controller do
      include CanvasSupport

      before_action :protect_canvas_api

      def index
        result = canvas_api.proxy(params[:lms_proxy_call_type], params.to_unsafe_h, request.body.read)
        response.status = result.code

        render plain: result.body
      end
    end

    it "provides access to the canvas api" do
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS",
        context_id: @context_id,
      }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "no api token for application instance or user" do
    before do
      @user = FactoryBot.create(:user)
      allow(controller).to receive(:current_user).and_return(@user)

      @user.add_to_role("urn:lti:role:ims/lis/Learner")
      @user.save!

      canvas_api_permissions = {
        default: [
          "administrator", # Internal (non-LTI) role
          "urn:lti:sysrole:ims/lis/SysAdmin",
          "urn:lti:sysrole:ims/lis/Administrator",
          "urn:lti:role:ims/lis/Learner",
        ],
        common: [],
        LIST_ACCOUNTS: [],
      }

      @application_instance.application.update(canvas_api_permissions: canvas_api_permissions)
      @application_instance.update(canvas_token: nil)

      @user_token = AuthToken.issue_token({ user_id: @user.id })
      @user_token_header = "Bearer #{@user_token}"
    end

    controller do
      include CanvasSupport

      before_action :protect_canvas_api

      def index
        result = canvas_api.proxy(params[:lms_proxy_call_type], params.to_unsafe_h, request.body.read)
        response.status = result.code

        render plain: result.body
      end
    end

    it "returns an authorization required if it can't find a canvas api token" do
      request.headers["Authorization"] = @user_token_header
      get :index, params: {
        lti_key: @application_instance.lti_key,
        lms_proxy_call_type: "LIST_ACCOUNTS",
      }, format: :json
      result = JSON.parse(response.body)
      expect(result["message"]).to eq("Unable to find valid Canvas API Token.")
      expect(result["canvas_authorization_required"]).to eq(true)
    end
  end
end
