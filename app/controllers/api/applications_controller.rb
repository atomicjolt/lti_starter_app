class Api::ApplicationsController < Api::ApiApplicationController

  load_and_authorize_resource :application

  def index
    render status: 200, json: @applications.lti
  end

  def update
    @application.update(application_params)
    respond_with(@application)
  end

  private

  def application_params
    params.require(:application).permit(:name, :description)
  end

end
