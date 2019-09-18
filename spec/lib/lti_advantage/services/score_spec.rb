require "rails_helper"

RSpec.describe LtiAdvantage::Services::Score do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
    @lti_token = LtiAdvantage::Authorization.validate_token(@application_instance, @params["id_token"])
    @score_service = LtiAdvantage::Services::Score.new(@application_instance, @lti_token)
    @score_service.id = "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/31"
  end

  describe "send" do
    it "sends a score for the specified line item" do
      score = @score_service.generate(
        user_id: "cfca15d8-2958-4647-a33e-a7c4b2ddab2c",
        score: 10,
        max_score: 10,
        comment: "Great job",
        activity_progress: "Completed",
        grading_progress: "FullyGraded",
      )
      result = JSON.parse(@score_service.send(score))
      expect(result["resultUrl"].present?).to be true
    end
  end
end
