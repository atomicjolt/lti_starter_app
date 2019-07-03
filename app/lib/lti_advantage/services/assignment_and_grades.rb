module LtiAdvantage
  module Services
    class AssignmentAndGrades < LtiAdvantage::Services::Base

      def headers
        super({
          "Content-Type" => "application/vnd.ims.lis.v1.score+json",
        })
      end

      def valid?
        def assignment_and_grades_launch?(jwt_body)
          jwt_body[Rails.configuration.lti_claims_and_scopes['ags_claim']]
        end
      end

      def generate(score:, max_score:, comment: "", activity_progress: "Completed", grading_progress: "FullyGraded")
        {
          timestamp: Time.now,
          scoreGiven: score,
          scoreMaximum: max_score,
          comment: comment,
          activityProgress: activity_progress,
          gradingProgress: grading_progress,
          userId: @lti_token["sub"],
        }
      end

      def post_score(score_details)
        endpoint = @lti_token.dig(AGS_CLAIM, "lineitem") + "/scores.json"
        HTTParty.post(
          endpoint,
          body: score_details,
          headers: headers,
        )
      end

    end
  end
end
