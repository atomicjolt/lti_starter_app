require "rails_helper"

RSpec.describe OmniauthCallbacksController, type: :controller do
  render_views

  class MockStrategy
    def name
      "canvas"
    end
  end

  before do
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["omniauth.strategy"] = MockStrategy.new
    @app = FactoryGirl.create(:application_instance)
    allow(controller).to receive(:current_application_instance).and_return(@app)
  end

  describe "GET canvas" do
    it "should pass through with valid auth" do
      FactoryGirl.create :user_canvas
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:canvas]
      oauth_complete_url = "http://www.example.com"
      response = get :canvas, params: {
        oauth_complete_url: oauth_complete_url,
        canvas_url: "https://example.instructure.com",
      }

      expect(response).to redirect_to oauth_complete_url
    end

    it "should redirect to origin without auth" do
      origin_url = "http://www.example.com"
      request.env["omniauth.origin"] = origin_url

      response = get :canvas
      expect(response).to redirect_to origin_url
    end

    it "should redirect with error params" do
      origin_url = "http://www.example.com"
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
