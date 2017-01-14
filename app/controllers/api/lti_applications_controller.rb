class Api::LtiApplicationsController < ApplicationController

  include Concerns::JwtToken

  before_action :validate_token

  respond_to :json

  def index
    applications = Application.lti
    json_applications = applications.map do |application|
      json = application.as_json
      json[:instances] = ApplicationInstance.where(application_id: application.id).count
      json
    end
    render status: 200, json: { lti_applications: json_applications }
  end

end
