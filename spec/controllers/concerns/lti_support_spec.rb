require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    @app = FactoryGirl.create(:application_instance)
    @launch_url = "http://test.host/anonymous" # url when posting to anonymous controller created below.
    allow(controller).to receive(:current_application_instance).and_return(@app)
    allow(Application).to receive(:find_by).with(:lti_key).and_return(@app)
  end

  controller do
    include Concerns::LtiSupport

    skip_before_filter :verify_authenticity_token
    before_action :do_lti

    def index
      render text: "User: #{current_user.display_name}"
    end
  end

  describe "LTI" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end

    context "valid LTI request" do
      it "sets up the user, logs them in and renders the lti launch page" do
        # Create a user with the same email as for this spec thus forcing
        # a generated email to happen for the new lti user.
        FactoryGirl.create(:user, email: "steve@apple.com")

        params = lti_params(@app.lti_key, @app.lti_secret, { "launch_url" => @launch_url, "roles" => "Learner" })
        post :index, params
        expect(response).to have_http_status(200)
        expect(response.body).to include("User:")
      end
    end

    context "invalid LTI request" do
      it "should return unauthorized status" do
        params = lti_params(@app.lti_key, @app.lti_secret, { "launch_url" => @launch_url })
        params[:context_title] = "invalid"
        post :index, params
        expect(response).to have_http_status(401)
      end
    end
  end
end
