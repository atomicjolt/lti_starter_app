require "rails_helper"

RSpec.describe OmniauthCallbacksController, type: :controller do

  class MockStrategy
    def name
      "canvas"
    end
  end

  class MockError
    def to_s
      "No soup for you!"
    end

    def description
      error_reason
    end
  end

  before do
    setup_application_instance
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["omniauth.strategy"] = MockStrategy.new
    request.env["oauth_state"] = {
      site_id: @application_instance.site.id,
      application_instance_id: @application_instance.id,
      oauth_complete_url: nil,
      user_id: nil,
    }.stringify_keys

    @canvas_url = "https://example.instructure.com"
    @application_instance.site.update(url: @canvas_url)
    @username = "theusername"
    @lti_user_id = FactoryBot.generate(:name)
    @email = FactoryBot.generate(:email)
    @canvas_opts = {
      "uid" => "auniqueidprovidedbycanvas",
      "username" => @username,
      "lti_user_id" => @lti_user_id,
      "credentials" => {
        "token" => FactoryBot.generate(:token),
        "secret" => FactoryBot.generate(:token),
        "refresh_token" => FactoryBot.generate(:token),
      },
      "info" => {
        "email" => @email,
        "url" => @canvas_url,
      },
    }
  end

  describe "GET canvas" do
    before do
      ai = @application_instance
      path = "applications/#{ai.application_id}/application_instances/#{ai.id}/installs"
      @oauth_complete_url = "#{admin_root_url}##{path}"
      request.env["oauth_state"]["oauth_complete_url"] = @oauth_complete_url
    end

    it "should logout an existing user" do
      old_user = FactoryBot.create :user
      sign_in(old_user)
      expect(subject.current_user.id).to eq old_user.id

      user = FactoryBot.create :user_canvas
      authentication = user.authentications.find_by(provider: "canvas")
      canvas_opts = {
        "uid" => authentication.uid,
        "info" => {
          "url" => authentication.provider_url,
        },
      }
      request.env["omniauth.auth"] = get_canvas_omniauth(canvas_opts)

      response = get :canvas, params: {}
      expect(response).to have_http_status 302
      expect(subject.current_user.id).to eq user.id
    end

    context "in an lti launch" do
      before do
        @user = FactoryBot.create :user
        @user.authentications.destroy_all
        canvas_opts = {
          "uid" => @user.lms_user_id,
          "info" => {
            "url" => @application_instance.site.url,
          },
        }
        request.env["omniauth.auth"] = get_canvas_omniauth(canvas_opts)
        request.env["oauth_state"]["user_id"] = @user.id
        request.env["oauth_state"]["oauth_complete_url"] = nil
      end
      it "should relogin the previous lti user" do
        response = get :canvas, params: {}
        expect(response).to have_http_status 200
        expect(subject.current_user.id).to eq @user.id
      end
      it "should add an authentication" do
        response = get :canvas, params: {}
        expect(response).to have_http_status 200
        expect(subject.current_user.id).to eq @user.id
        expect(@user.authentications.count).to eq 1
      end
      it "should error if the previous lti user has a different lms_user_id" do
        @user.update(lms_user_id: "something_else")
        response = get :canvas, params: {}
        expect(response).to have_http_status 403
        expect(@user.authentications.count).to eq 0
        expect(subject.current_user).to be nil
        expect(subject).to render_template("omniauth/error")
      end
      it "should render oauth complete" do
        response = get :canvas, params: {}
        expect(response).to have_http_status 200
        expect(subject.current_user.id).to eq @user.id
        expect(subject).to render_template("omniauth/complete")
      end
    end

    it "should pass through with valid auth" do
      user = FactoryBot.create :user_canvas
      authentication = user.authentications.find_by(provider: "canvas")
      canvas_opts = {
        "uid" => authentication.uid,
        "info" => {
          "url" => authentication.provider_url,
        },
      }
      request.env["omniauth.auth"] = get_canvas_omniauth(canvas_opts)

      response = get :canvas, params: {}

      expect(response).to redirect_to @oauth_complete_url
    end

    it "creates a new user" do
      request.env["omniauth.auth"] = get_canvas_omniauth(@canvas_opts)
      expect { get :canvas, params: {} }.to change { User.count }.by(1)
      expect(User.last.lms_user_id).to eq request.env["omniauth.auth"]["uid"]
    end

    it "creates a new user without causing conflicts" do
      request.env["omniauth.auth"] = get_canvas_omniauth(@canvas_opts)
      FactoryBot.create :user_canvas,
        lti_user_id: request.env["omniauth.auth"].dig("extra", "raw_info", "lti_user_id"),
        legacy_lti_user_id: request.env["omniauth.auth"].dig("extra", "raw_info", "lti_user_id"),
        lms_user_id: request.env["omniauth.auth"]["uid"]
      expect { get :canvas, params: {} }.to change { User.count }.by(1)
      expect(User.last.lms_user_id).to eq request.env["omniauth.auth"]["uid"]
    end

    it "should redirect to oauth_complete_url with user authenticated" do
      user = FactoryBot.create :user_canvas
      authentication = user.authentications.find_by(provider: "canvas")
      canvas_opts = {
        "uid" => authentication.uid,
        "info" => {
          "url" => authentication.provider_url,
        },
      }
      request.env["omniauth.auth"] = get_canvas_omniauth(canvas_opts)
      user.lti_user_id = User.oauth_lti_user_id(request.env["omniauth.auth"])
      user.save!
      response = get :canvas, params: {}

      expect(warden.authenticated?(:user)).to be true
      expect(warden.user).to eq(user)
      expect(response).to have_http_status 302
    end

    it "should render oauth error page" do
      origin_url = "http://example.com"
      request.env["omniauth.origin"] = origin_url
      request.env["omniauth.strategy"] = nil

      response = get :canvas, params: {}

      expect(response).to have_http_status 403
    end

    it "should fix the provider_url" do
      request.env["omniauth.auth"] = get_canvas_omniauth(@canvas_opts)
      expect(request.env["omniauth.auth"]["info"]["url"]).to be
      request.env["omniauth.auth"]["info"]["url"] = "https://vanity.canvas.com"
      expect { get :canvas, params: {} }.to change { User.count }.by(1)
      expect(User.last.lms_user_id).to eq request.env["omniauth.auth"]["uid"]
      expect(User.last.authentications.last.provider_url).to eq @application_instance.site.url
    end

    it "should render oauth error page when no origin is available" do
      request.env["omniauth.error"] = MockError.new
      response = get :canvas

      expect(response).to have_http_status 403
    end

    it "should render all errors" do
      request.env["oauth_state"]["oauth_complete_url"] = nil
      request.env["omniauth.error"] = MockError.new

      request.env["omniauth.error.type"] = :unauthorized_client
      response = get :canvas
      expect(response).to have_http_status 403

      request.env["omniauth.error.type"] = :access_denied
      response = get :canvas
      expect(response).to have_http_status 403

      request.env["omniauth.error.type"] = :missing_permissions
      response = get :canvas
      expect(response).to have_http_status 403

      request.env["omniauth.error.type"] = :something_else
      response = get :canvas
      expect(response).to have_http_status 403

      request.env["oauth_state"]["oauth_complete_url"] = "https://www.example.com"
      request.env["omniauth.error.type"] = :something_else
      response = get :canvas
      expect(response).to have_http_status 403
    end
  end
end
