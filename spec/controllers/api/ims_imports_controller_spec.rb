require "rails_helper"

RSpec.describe Api::ImsImportsController, type: :controller do
  before do
    setup_application_and_instance
    initial_context_id = "a07291ea2fa1315059ed3bf0135a336d1eebe057"
    @import_context_id = "3155b3a04eba69bc0e52b987d3ffc465156daded"
    @ims_export = FactoryGirl.create(:ims_export)

    @lti_launch_one = FactoryGirl.create(:lti_launch, context_id: initial_context_id)
    @lti_launch_two = FactoryGirl.create(:lti_launch, context_id: initial_context_id)
    lti_launches = LtiLaunch.where(context_id: initial_context_id)

    @import_params = {
      context_id: @import_context_id,
      data: {
        context_id: initial_context_id,
        application_instance_id: @application_instance.id,
        ims_export_id: @ims_export.token,
        lti_launch_tokens: lti_launches.pluck(:token),
      },
      tool_consumer_instance_guid: "4MRcxnx6vQbFXxhLb8005m5WXFM2Z2i8lQwhJ1QT:canvas-lms",
      custom_canvas_course_id: "2123",
    }
  end

  context "without jwt token" do
    it "should not be authorized" do
      post :create, params: @import_params, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with jwt token" do
    before do
      # For authentication a JWT will be included in the Authorization header using the Bearer scheme,
      # it is signed using the shared secret for the tool and will include the stored consumer key in the
      # kid field of the token's header object.
      payload = {}
      @token = AuthToken.issue_token(
        payload,
        24.hours.from_now,
        @application_instance.lti_secret,
        nil,
        { kid: @application_instance.lti_key },
      )
      request.headers["Authorization"] = "Bearer #{@token}"
    end

    describe "POST create" do
      it "starts the export process" do
        post :create, params: @import_params, format: :json
        expect(response).to have_http_status(:success)
        new_lti_launch_one = LtiLaunch.find_by(token: @lti_launch_one.token, context_id: @import_context_id)
        expect(new_lti_launch_one.token).to eq(@lti_launch_one.token)
        new_lti_launch_two = LtiLaunch.find_by(token: @lti_launch_two.token, context_id: @import_context_id)
        expect(new_lti_launch_two.token).to eq(@lti_launch_two.token)
        result = JSON.parse(response.body)
        expect(result["status"]).to eq("completed")
      end
    end
  end
end
