class Api::ApplicationsController < Api::ApiApplicationController

  load_and_authorize_resource :application

  def index
    applications = Application.lti
    json_applications = applications.map do |application|
      json = application.as_json
      json[:instances] = ApplicationInstance.where(application_id: application.id).count
      json
    end
    render status: 200, json: { applications: json_applications }
  end

end
