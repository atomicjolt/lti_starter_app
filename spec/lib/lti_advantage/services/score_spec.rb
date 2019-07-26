require "rails_helper"

RSpec.describe LtiAdvantage::Authorization do
  before do
    setup_application_instance
    @platform_iss = "https://canvas.instructure.com"
    setup_canvas_lti_advantage(
      application_instance: @application_instance,
      iss: @platform_iss
    )
  end

  describe "send" do
    it "sends a score to the platform" do
      service = LtiAdvantage::Services::Score.new(@application_instance, @lti_token)
      service.id = "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/31"
      attrs = service.generate(user_id: 1, score: 10, max_score: 10)
      result = service.send(attrs)
      expect(result.code).to eq(200)
      expect(JSON.parse(result.body)["resultUrl"].empty?).to be false
    end
  end
end
