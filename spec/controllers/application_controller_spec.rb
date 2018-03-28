require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "helper methods" do
    describe "#current_application_instance" do
      it "returns the current application instance" do
        application_instance = FactoryBot.create(:application_instance)
        subject.params = {
          oauth_consumer_key: application_instance.lti_key,
        }
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
        application_instance = FactoryBot.create(:application_instance)
        subject.params = {
          oauth_consumer_key: application_instance.lti_key,
        }
        expect(subject.send(:canvas_url)).to eq(application_instance.site.url)
      end
    end
  end
end
