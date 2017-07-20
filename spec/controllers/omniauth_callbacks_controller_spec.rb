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
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:canvas]
    request.env["omniauth.strategy"] = MockStrategy.new
  end

  describe "verify_oauth_response" do
    # it "should pass through with valid auth" do
    #
    # end

    it "should redirect to origin" do
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
