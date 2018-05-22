require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    @application_instance = FactoryBot.create(:application_instance)
    @launch_url = "http://test.host/anonymous" # url when posting to anonymous controller created below.
    allow(controller).to receive(:current_application_instance).and_return(@application_instance)
    allow(Application).to receive(:find_by).with(:lti_key).and_return(@application_instance)
  end

  controller do
    include Concerns::LtiSupport

    skip_before_action :verify_authenticity_token
    before_action :do_lti

    def index
      render plain: "User: #{current_user.display_name}"
    end
  end

  describe "LTI" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end

    context "valid LTI request" do
      context "user doesn't exist" do
        it "sets up the user, logs them in and renders the lti launch page" do
          # Create a user with the same email as for this spec thus forcing
          # a generated email to happen for the new lti user.
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => "Learner",
            },
          )
          FactoryBot.create(:user, email: params["lis_person_contact_email_primary"])
          post :index, params: params
          expect(response).to have_http_status(200)
          expect(response.body).to include("User:")
        end
        it "creates an anonymous user" do
          @application_instance.anonymous = true
          @application_instance.save!
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => "Learner",
            },
          )
          post :index, params: params
          expect(response).to have_http_status(200)
          expect(response.body).to include("User: anonymous")
        end
      end

      context "user already exists" do
        before do
          @role = "urn:lti:role:ims/lis/Instructor"
          @email = FactoryBot.generate(:email)
          @params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => @role,
              "lis_person_contact_email_primary" => @email,
            },
          )
        end
        it "adds lti roles to an existing user" do
          FactoryBot.create(
            :user,
            email: @email,
            lti_provider: @params["tool_consumer_instance_guid"],
            lti_user_id: @params["user_id"],
          )
          post :index, params: @params
          expect(response).to have_http_status(200)
          user = User.find_by(email: @email)
          expect(user.role?(@role, @params["context_id"])).to be true
        end
        it "updates the lti_user_id of a user with a matching lms_user_id" do
          user = FactoryBot.create(
            :user,
            lti_provider: @params["tool_consumer_instance_guid"],
            lms_user_id: 23459,
          )
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => @role,
              "lis_person_contact_email_primary" => user.email,
              "custom_canvas_user_id" => user.lms_user_id,
            },
          )
          post :index, params: params
          expect(response).to have_http_status(200)
          user = User.find_by(email: user.email)
          expect(user.lti_user_id).to eq params["user_id"]
        end
        context "two users with matching lms_user_id exist but only one has an LTI user id" do
          it "finds the user with the lms_user_id and lti_user_id" do
            FactoryBot.create(
              :user,
              email: @email,
              lti_provider: @params["tool_consumer_instance_guid"],
              lti_user_id: @params["user_id"],
              lms_user_id: 98761,
            )
            email = FactoryBot.generate(:email)
            FactoryBot.create(
              :user,
              email: email,
              lti_provider: @params["tool_consumer_instance_guid"],
              lms_user_id: 98761,
            )
            post :index, params: @params
            expect(response).to have_http_status(200)
            user = User.find_by(email: @email)
            expect(user.lti_user_id).to eq @params["user_id"]
          end
        end
      end
    end

    context "invalid LTI request" do
      it "should return unauthorized status" do
        params = lti_params(
          @application_instance.lti_key,
          @application_instance.lti_secret,
          {
            "launch_url" => @launch_url,
          },
        )
        params[:context_title] = "invalid"
        post :index, params: params
        expect(response).to have_http_status(401)
      end
    end
  end
end
