require "rails_helper"

RSpec.describe LtiAdvantage::Authorization do
  before do
    setup_application_instance
    @platform_iss = "https://canvas.instructure.com"
    setup_canvas_lti_advantage(
      application_instance: @application_instance,
      iss: @platform_iss
    )
    @line_item = {
      "id" => "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/25"
    }
  end

  describe "list" do
    it "lists results" do
      results_service = LtiAdvantage::Services::Results.new(@application_instance, @lti_token)
      result = results_service.list(@line_item["id"])
      line_item_results = JSON.parse(result)
      expect(line_item_results).to be
    end
  end

  describe "show" do
    it "gets a single result" do
      results_service = LtiAdvantage::Services::Results.new(@application_instance, @lti_token)
      result_id = 2
      result = results_service.show(@line_item["id"], result_id)
      line_item_result = JSON.parse(result)
      expect(line_item_result).to be
    end
  end
end
