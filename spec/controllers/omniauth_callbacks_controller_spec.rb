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

  describe "verify_oauth_response" do
    it "should pass through with valid auth" do
      @user = FactoryGirl.create :user_canvas

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:canvas]
      oauth_complete_url = "http://example.com"
      response = get :canvas, params: {
        oauth_complete_url: oauth_complete_url,
        canvas_url: "https://example.instructure.com",
      }

      expect(response).to redirect_to oauth_complete_url
    end

    it "should redirect to origin without auth" do
      origin_url = "http://example.com"
      request.env["omniauth.origin"] = origin_url

      response = get :canvas
      expect(response).to redirect_to origin_url
    end
    #
    # it "should redirect with error params" do
    # end
    #
    # it "should redirect to oautherror page when no origin is available" do
    # end
  end
end
