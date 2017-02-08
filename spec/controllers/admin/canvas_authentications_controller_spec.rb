require "rails_helper"

RSpec.describe Admin::CanvasAuthenticationsController, type: :controller do
  describe "POST create" do
    describe "with valid canvas url" do
      it "redirects to the canvas omniauth path" do
        post :create, { canvas_url: Rails.application.secrets.canvas_url }
        expect(response).to be_redirect
      end
    end
    describe "empty canvas url" do
      it "tells the user to enter a canvas url" do
        post :create, { canvas_url: "" }
        expect(response).to redirect_to admin_lti_installs_path
      end
    end
    describe "with invalid canvas url" do
      it "tells the user to enter a valid canvas url" do
        post :create, { canvas_url: "www .example.com" }
        expect(response).to redirect_to admin_lti_installs_path
      end
    end
  end
end
