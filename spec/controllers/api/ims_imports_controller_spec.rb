require "rails_helper"

RSpec.describe Api::ImsImportsController, type: :controller do
  include ActiveJob::TestHelper

  after do
    clear_enqueued_jobs
  end

  before do
    setup_application_instance
    tool_consumer_instance_guid = "4MRcxnx6vQbFXxhLb8005m5WXFM2Z2i8lQwhJ1QT:canvas-lms"
    initial_context_id = "a07291ea2fa1315059ed3bf0135a336d1eebe057"
    @import_context_id = "3155b3a04eba69bc0e52b987d3ffc465156daded"
    @ims_export = FactoryBot.create(:ims_export)

    lti_launch_tokens = Apartment::Tenant.switch(@application_instance.tenant) do
      @lti_launch_one = FactoryBot.create(
        :lti_launch,
        context_id: initial_context_id,
        tool_consumer_instance_guid: tool_consumer_instance_guid,
      )
      @lti_launch_two = FactoryBot.create(
        :lti_launch,
        context_id: initial_context_id,
        tool_consumer_instance_guid: tool_consumer_instance_guid,
      )
      LtiLaunch.where(context_id: initial_context_id).pluck(:token)
    end

    @import_params = {
      context_id: @import_context_id,
      data: {
        tool_consumer_instance_guid: tool_consumer_instance_guid,
        context_id: initial_context_id,
        "lti_launches" => [
          { "token" => "dgqgRSCUGdkmmKMAC3Ma2nei", "config" => {"is_embedded" => "true", "iframe_height" => "510", "learnosity_activity_reference_id" => "Dynamic Content"}, "assignment" => {"embed_url" => nil, "is_embedded" => "true", "reference_id" => "Dynamic Content", "resource_title" => "Dynamic Content", "lms_assignment_override_id" => nil}, "context_id" => "3155b3a04eba69bc0e52b987d3ffc465156daded", "tool_consumer_instance_guid" => nil}, {"token" => "kcgmuAKNyRu55S1kT4XuY5ag", "config" => {"is_embedded" => "false", "iframe_height" => "510", "learnosity_activity_reference_id" => "Animals"}, "assignment" => {"embed_url" => nil, "is_embedded" => "false", "reference_id" => "Animals", "resource_title" => "Added via the connector", "$canvas_course_id" => "2114", "$canvas_assignment_id" => "19189", "lms_assignment_override_id" => nil}, "context_id" => "3155b3a04eba69bc0e52b987d3ffc465156daded", "tool_consumer_instance_guid" => nil}, {"token" => "jfvTHBDVW68y9auBLGihpq3G", "config" => {"is_embedded" => "true", "assignment_id" => "101", "iframe_height" => "510", "learnosity_activity_reference_id" => "Joseph Test"}, "assignment" => {"embed_url" => nil, "is_embedded" => "true", "reference_id" => "Joseph Test", "resource_title" => "Joseph Test", "$canvas_course_id" => "2114", "$canvas_assignment_id" => "$OBJECT_NOT_FOUND", "lms_assignment_override_id" => nil}, "context_id" => "3155b3a04eba69bc0e52b987d3ffc465156daded", "tool_consumer_instance_guid" => nil}, {"token" => "N4aDqFbQzQFrPhqzyZuEJErd", "config" => {"is_embedded" => "true", "assignment_id" => "102", "iframe_height" => "510", "learnosity_activity_reference_id" => "SETH"}, "assignment" => {"embed_url" => nil, "is_embedded" => "true", "reference_id" => "SETH", "resource_title" => "SETH", "$canvas_course_id" => "2114", "$canvas_assignment_id" => "19190", "lms_assignment_override_id" => nil}, "context_id" => "3155b3a04eba69bc0e52b987d3ffc465156daded", "tool_consumer_instance_guid" => nil }
        ],
        "application_instance_id" => "3",
        "export_token" => @ims_export.token,
      },
      tool_consumer_instance_guid: tool_consumer_instance_guid,
      custom_canvas_course_id: "2123",
    }
  end

  context "without jwt token" do
    it "should not be authorized" do
      post :create, params: @import_params, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with jwt token" do
    before do
      # For authentication a JWT will be included in the Authorization header using the Bearer scheme,
      # it is signed using the shared secret for the tool and will include the stored consumer key in the
      # kid field of the token's header object.
      @token = JWT.encode(
        { exp: 24.hours.from_now.to_i },
        @application_instance.lti_secret,
        "HS256",
        { typ: "JWT", alg: "HS256", kid: @application_instance.lti_key },
      )
      request.headers["Authorization"] = "Bearer #{@token}"
    end

    describe "POST create" do
      context "background jobs" do
        it "enqueues processing" do
          expect do
            post :create, params: @import_params, as: :json
          end.to have_enqueued_job(ImsImportJob)
        end
      end

      context "no lti_launches" do
        it "enqueues processing" do
          import_params = @import_params.with_indifferent_access
          import_params[:data].delete(:lti_launches)
          expect do
            post :create, params: import_params, as: :json
          end.to have_enqueued_job(ImsImportJob)
        end

        it "enqueues processing with nil lti_launches" do
          import_params = @import_params.with_indifferent_access
          import_params[:data].delete(:lti_launches)
          data = {
            lti_launches: nil,
            context_id: import_params[:context_id],
            tool_consumer_instance_guid: import_params[:tool_consumer_instance_guid],
          }

          # We assign the args to this external variable because failing
          # expects inside the block just get caught by the controller's error
          # handling.
          received_args = nil
          expect(ImsImportJob).to receive(:perform_later) do |args|
            received_args = JSON.parse(args)
          end

          post :create, params: import_params, as: :json

          expect(received_args).to be_present
          expect(received_args.without("ims_import_id")).to eq data.as_json
          expect(received_args["ims_import_id"]).to be_present
        end
      end
    end
  end
end
