class Api::ApplicationsController < Api::ApiApplicationController

  load_and_authorize_resource :application

  def index
    render status: 200, json: @applications.lti
  end

end
