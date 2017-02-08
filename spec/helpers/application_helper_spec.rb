require "rails_helper"

describe ApplicationHelper do
  describe "#canvas_url" do
    it "provides the canvas url from settings" do
      application_instance = FactoryGirl.create(:application_instance)

      # HACK this is really ugly but rspec won't let us stub methods that don't exist
      # directly on the object. current_application_instance lives in the application controller
      # but is exposed as a helper method and canvas_url depends on that method. We have to
      # stub in a method ourselves until this pull request is accepted:
      # https://github.com/rspec/rspec-mocks/pull/1104
      helper.class.instance_eval do
        define_method(:current_application_instance) { application_instance }
      end

      expect(helper.canvas_url).to eq(application_instance.site.url)
    end
  end

  describe "application_base_url" do
    it "adds a trailing / onto the request's base url" do
      expect(helper.application_base_url).to be
    end
  end

  describe "jwt_token" do
    it "generates a new jwt token" do
      expect(helper).to receive("signed_in?").and_return(true)
      expect(helper).to receive(:current_user).and_return(double(id: 1))
      result = helper.jwt_token
      expect(result).to be
    end
  end
end
