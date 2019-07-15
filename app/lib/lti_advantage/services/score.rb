module LtiAdvantage
  module Services
    # Canvas docs: https://canvas.instructure.com/doc/api/score.html
    class Score < LtiAdvantage::Services::Base

      attr_accessor :id

      def endpoint
        if id.blank?
          raise ::LtiAdvantage::Exceptions::ScoreError,
            "Invalid id or no id provided. Unable to access scores. id should be in the form of a url."
        end
        "#{id}/scores"
      end

      def generate(
        user_id:,
        score:,
        max_score:,
        comment: nil,
        activity_progress: "Completed",
        grading_progress: "FullyGraded"
      )
        {
          # The lti_user_id or the Canvas user_id
          userId: user_id,
          # The Current score received in the tool for this line item and user, scaled to
          # the scoreMaximum
          scoreGiven: score,
          # Maximum possible score for this result; it must be present if scoreGiven is
          # present.
          scoreMaximum: max_score,
          # Comment visible to the student about this score.
          comment: comment,
          # Date and time when the score was modified in the tool. Should use subsecond
          # precision.
          timestamp: Time.now,
          # Indicate to Canvas the status of the user towards the activity's completion.
          # Must be one of Initialized, Started, InProgress, Submitted, Completed
          activityProgress: activity_progress,
          # Indicate to Canvas the status of the grading process. A value of
          # PendingManual will require intervention by a grader. Values of NotReady,
          # Failed, and Pending will cause the scoreGiven to be ignored. FullyGraded
          # values will require no action. Possible values are NotReady, Failed, Pending,
          # PendingManual, FullyGraded
          gradingProgress: grading_progress,
        }
      end

      def send(attrs)
        HTTParty.post(
          endpoint,
          body: attrs,
          headers: headers,
        )
      end

    end
  end
end
