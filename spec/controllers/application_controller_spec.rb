require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  before do
    setup_application_instance(mock_helper: false)
    setup_canvas_lti_advantage(application_instance: @application_instance)
  end
  describe "helper methods" do
    describe "#current_application_instance" do
      it "returns the current application instance" do
        request.params[:oauth_consumer_key] = @application_instance.lti_key
        expect(subject.send(:current_application_instance)).to eq(@application_instance)
      end
      it "returns the current application instance using id_token" do
        application_instance = FactoryBot.create(:application_instance)
        params = setup_canvas_lti_advantage(application_instance: application_instance)
        setup_atomic_lti_values(application_instance: application_instance)
        request.params["id_token"] = @id_token
        expect(subject.send(:current_application_instance)).to eq(application_instance)
      end
    end

    describe "#current_bundle_instance" do
      it "returns the canvas url" do
        bundle_instance = FactoryBot.create(:bundle_instance)
        subject.params = {
          bundle_instance_token: bundle_instance.id_token,
        }
        expect(subject.send(:current_bundle_instance)).to eq(bundle_instance)
      end
    end

    describe "#current_user_roles" do
      it "returns the roles for the current user when context is nil" do
        role = "admin"
        user = FactoryBot.create(:user)
        user.add_to_role(role)
        allow(subject).to receive(:current_user).and_return(user)
        expect(subject.send(:current_user_roles)).to eq([role])
      end
      it "returns the roles for the current user for a given context" do
        context_id = "math101"
        role = "urn:lti:role:ims/lis/Instructor"
        user = FactoryBot.create(:user)
        user.add_to_role(role, context_id)
        allow(subject).to receive(:current_user).and_return(user)
        expect(subject.send(:current_user_roles, context_id: context_id)).to eq([role])
      end
      it "does not return roles from other context" do
        instructor_context_id = "math101"
        learner_context_id = "math600"
        instructor_role = "urn:lti:role:ims/lis/Instructor"
        learner_role = "urn:lti:role:ims/lis/Learner"
        user = FactoryBot.create(:user)
        user.add_to_role(instructor_role, instructor_context_id)
        user.add_to_role(learner_role, learner_context_id)
        allow(subject).to receive(:current_user).and_return(user)
        expect(subject.send(:current_user_roles, context_id: learner_context_id)).to eq([learner_role])
      end
    end

    describe "#canvas_url" do
      it "returns the canvas url" do
        request.params[:oauth_consumer_key] = @application_instance.lti_key
        expect(subject.send(:canvas_url)).to eq(@application_instance.site.url)
      end
    end

    describe "Exception handlers" do
      before do
        allow(controller).to receive(:current_application_instance).and_return(@application_instance)
      end

      describe "CanCan::AccessDenied exception" do
        controller do
          def index
            raise CanCan::AccessDenied
          end
        end
        it "renders a unauthorized page" do
          get :index
          expect(response).to have_http_status(403)
        end
        it "renders unauthorized json" do
          get :index, format: :json
          expect(response).to have_http_status(403)
          expect(JSON.parse(response.body)["message"]).to eq("You are not authorized to access this page.")
        end
      end

      describe "Exception" do
        controller do
          def index
            raise Exception
          end
        end
        it "renders an error page" do
          get :index
          expect(response).to have_http_status(500)
        end
        it "renders error json" do
          get :index, format: :json
          expect(response).to have_http_status(500)
          expect(JSON.parse(response.body)["message"]).to eq("Internal error: Exception")
        end
      end

      describe "LMS::Canvas::CanvasException" do
        controller do
          def index
            raise LMS::Canvas::CanvasException
          end
        end
        it "renders an error page" do
          get :index
          expect(response).to have_http_status(500)
        end
        it "renders error json" do
          get :index, format: :json
          expect(response).to have_http_status(500)
          expect(JSON.parse(response.body)["message"]).to eq("Error while accessing Canvas: .")
        end
      end

      describe "LMS::Canvas::RefreshTokenFailedException" do
        controller do
          def index
            raise LMS::Canvas::RefreshTokenFailedException
          end
        end
        it "renders an error page" do
          get :index
          expect(response).to have_http_status(401)
        end
        it "renders error json" do
          get :index, format: :json
          expect(response).to have_http_status(401)
          result = JSON.parse(response.body)
          expect(result["message"]).to eq("Canvas API Token has expired.")
          expect(result["canvas_authorization_required"]).to eq(true)
        end
      end

      describe "LMS::Canvas::RefreshTokenRequired" do
        controller do
          def index
            raise LMS::Canvas::RefreshTokenRequired
          end
        end
        it "renders an error page" do
          get :index
          expect(response).to have_http_status(401)
        end
        it "renders error json" do
          get :index, format: :json
          expect(response).to have_http_status(401)
          result = JSON.parse(response.body)
          expect(result["message"]).to eq("Canvas API Token has expired.")
          expect(result["canvas_authorization_required"]).to eq(true)
        end
      end

      describe "Exceptions::CanvasApiTokenRequired" do
        controller do
          def index
            raise Exceptions::CanvasApiTokenRequired
          end
        end
        it "renders an error page" do
          get :index
          expect(response).to have_http_status(401)
        end
        it "renders error json" do
          get :index, format: :json
          expect(response).to have_http_status(401)
          result = JSON.parse(response.body)
          expect(result["message"]).to eq("Unable to find valid Canvas API Token.")
          expect(result["canvas_authorization_required"]).to eq(true)
        end
      end

      describe "LMS::Canvas::InvalidAPIRequestFailedException" do
        controller do
          def index
            raise LMS::Canvas::InvalidAPIRequestFailedException
          end
        end
        it "renders an error page" do
          get :index
          expect(response).to have_http_status(500)
        end
        it "renders error json" do
          get :index, format: :json
          expect(response).to have_http_status(500)
          result = JSON.parse(response.body)
          expect(result["message"]).to eq("An error occured when calling the Canvas API: ")
        end
      end
    end
  end
end
