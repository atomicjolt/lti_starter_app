require "caliper"

module Kaliper
  class Events

    attr_accessor :actor
    attr_accessor :ed_app
    attr_accessor :group
    attr_accessor :membership
    attr_accessor :session

    def initialize(application_instance:, user:)
      @application_instance = application_instance
      @user = user

      @actor = Caliper::Entities::Agent::Person.new(
        id: "#{@application_instance.domain}/users/#{@user.id}",
        name: @user.display_name,
      )

      @ed_app = Caliper::Entities::Agent::SoftwareApplication.new(
        id: @application_instance.domain,
        name: @application_instance.application.name,
        description: @application_instance.application.description,
      )
    end

    # tool use Event docs: https://www.imsglobal.org/sites/default/files/caliper/v1p1/caliper-spec-v1p1/caliper-spec-v1p1.html#toolUseEvent
    def tool_use_event(event_time: Time.now.utc.iso8601)
      event = Caliper::Events::ToolUseEvent.new(
        id: "urn:uuid:#{SecureRandom.uuid}",
        object: @ed_app,
        actor: @actor,
        action: Caliper::Actions::USED,
        edApp: @ed_app,
        eventTime: event_time
      )

      event.group = @group if @group
      event.membership = @membership if @membership
      event.session = @session if @session
      event.federated_session = @federated_session if @federated_session

      event
    end

  end
end
