require "rails_helper"

RSpec.describe HomeController, type: :controller do
  before do
    setup_application_instance
  end
  describe "GET index" do
    it "loads the home page" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
