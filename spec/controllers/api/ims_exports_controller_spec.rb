require "rails_helper"

RSpec.describe Api::ImsExportsController, type: :controller do
  before do
    setup_application_and_instance
    @export_params = {
      tool_consumer_instance_guid: "thisisatoolconsumerguid",
      context_id: "thisisacontextid",
    }
  end

  context "without jwt token" do
    it "should not be authorized" do
      post :create, params: @export_params, format: :json
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

    describe "GET show" do
      it "provides the payload of the export object" do
        ims_export = FactoryBot.create(:ims_export)
        get :show, params: { id: ims_export.token }, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result).to eq(ims_export.payload.merge("ims_export_id" => ims_export.token))
      end
    end

    describe "GET status" do
      it "provides the status of the export process" do
        ims_export = FactoryBot.create(:ims_export)
        get :status, params: { id: ims_export.token }, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["status"]).to eq("completed")
      end
    end

    describe "POST create" do
      it "starts the export process" do
        tool_consumer_instance_guid = ::SecureRandom::hex(15)
        export_params = {
          tool_consumer_instance_guid: tool_consumer_instance_guid,
          context_id: "thisisacontextid",
        }
        post :create, params: export_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        export = ImsExport.find_by(tool_consumer_instance_guid: tool_consumer_instance_guid)
        expect(result["status_url"]).to eq(status_api_ims_export_url(export.token))
        expect(result["fetch_url"]).to eq(api_ims_export_url(export.token))
      end
    end
  end
end
