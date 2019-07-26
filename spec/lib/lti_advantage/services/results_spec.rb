require "rails_helper"

RSpec.describe LtiAdvantage::Services::Results do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
    @lti_token = LtiAdvantage::Authorization.validate_token(@application_instance, @params["id_token"])
    @results_service = LtiAdvantage::Services::Results.new(@application_instance, @lti_token)
    @line_item_id = "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/31"
  end

  describe "list" do
    it "lists results for the specified line item" do
      results = JSON.parse(@results_service.list(@line_item_id).body)
      expect(results.length > 0).to be true
    end
  end

  describe "show" do
    it "gets specific result for the specified line item" do
      result_id = ""
      results = JSON.parse(@results_service.show(@line_item_id, result_id).body)
      expect(results.length > 0).to be true
    end
  end
end
