require "rails_helper"

RSpec.describe OmniauthCallbacksController, type: :controller do

  class MockStrategy
    def name
      "canvas"
    end
  end

  before do
    setup_application_instance
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["omniauth.strategy"] = MockStrategy.new
  end

  describe "GET canvas" do
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
      oauth_complete_url = "http://example.com"
      response = get :canvas, params: {
        oauth_complete_url: oauth_complete_url,
        canvas_url: "https://example.instructure.com",
      }

      expect(response).to redirect_to oauth_complete_url
    end

    it "should pass through with valid auth and a user logged in via lti credentials" do
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
      response = get :canvas, params: {
        canvas_url: "https://example.instructure.com",
        oauth_consumer_key: "ltikey",
      }

      expect(warden.authenticated?(:user)).to be true
      expect(warden.user).to eq(user)
      expect(response).to have_http_status 200
      expect(assigns(:is_lti_launch)).to eq true
    end

    it "should redirect to origin without auth" do
      origin_url = "http://example.com"
      request.env["omniauth.origin"] = origin_url

      response = get :canvas
      expect(response).to redirect_to origin_url
    end

    it "should redirect with error params" do
      origin_url = "http://example.com"
      request.env["omniauth.origin"] = origin_url
      error_params = { error: "failure" }
      response = get :canvas, params: {
        canvas_url: "https://example.instructure.com",
      }.merge(error_params)

      expect(response).to redirect_to "#{origin_url}?#{error_params.to_query}"
    end

    it "should render oauth error page when no origin is available" do
      response = get :canvas

      expect(response).to have_http_status 403
    end
  end
end
