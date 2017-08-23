require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "helper methods" do
    describe "#current_application_instance" do
      it "returns the current application instance" do
        application_instance = FactoryGirl.create(:application_instance)
        subject.params = {
          oauth_consumer_key: application_instance.lti_key,
        }
        expect(subject.send(:current_application_instance)).to eq(application_instance)
      end
    end

    describe "#current_bundle_instance" do
      it "returns the canvas url" do
        bundle_instance = FactoryGirl.create(:bundle_instance)
        subject.params = {
          bundle_instance_token: bundle_instance.id_token,
        }
        expect(subject.send(:current_bundle_instance)).to eq(bundle_instance)
      end
    end

    describe "#canvas_url" do
      it "returns the canvas url" do
        application_instance = FactoryGirl.create(:application_instance)
        subject.params = {
          oauth_consumer_key: application_instance.lti_key,
        }
        expect(subject.send(:canvas_url)).to eq(application_instance.site.url)
      end
    end
  end
end
