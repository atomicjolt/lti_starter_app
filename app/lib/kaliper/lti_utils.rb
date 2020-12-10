require "caliper"

module Kaliper
  class LtiUtils

    def self.from_lti_1_2(application_instance:, user:, params:)
      event = Kaliper::Events.new(application_instance: application_instance, user: user)

      if params[:customer_caliper_federated_session_id].present?
        # https://www.imsglobal.org/sites/default/files/caliper/v1p1/caliper-spec-v1p1/caliper-spec-v1p1.html#ltiSession
        event.federatedSession = Caliper::Entities::Session::LtiSession.new(
          id: params[:customer_caliper_federated_session_id],
          user: event.actor,
        )
      end

      #return from_canvas_lti(event, params) if params[:custom_canvas_api_domain].present?
      event
    end

    # TODO
    # def self.from_canvas_lti(event, params)

    #   event.group = Caliper::Entities::LIS::CourseSection.new(
    #     id: "https://#{params[:custom_canvas_api_domain]}/courses/#{params[:custom_canvas_course_id]}/sections/#{params[:custom_canvas_section_id]}",
    #     courseNumber: params[:context_title],
    #     academicSession: params[:canvas_term_start_at],
    #   )

    #   event.membership = Caliper::Entities::LIS::Membership.new(
    #     id: membership_id,
    #     member: event.actor,
    #     organization: event.group,
    #     roles: caliper_role_from(params),
    #     status: Caliper::Entities::LIS::Status::ACTIVE,
    #   )

    #   event.session = Caliper::Entities::Session::Session.new(
    #     id: id,
    #     startedAtTime: started_at.utc.iso8601,
    #   )
    # end

    # def self.caliper_role_from(params)
    #   roles = [ Caliper::Entities::LIS::Role::LEARNER ]
    # end

  end
end
