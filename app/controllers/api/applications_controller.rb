class Api::ApplicationsController < Api::ApiApplicationController

  load_and_authorize_resource :application

  def index
    render status: 200, json: @applications.lti
  end

  def update
    # Strong params doesn't allow arbitrary json to be permitted
    # So we have to explicitly set the default_config
    # This will be allowed in rails 5.1
    @application.default_config = params[:application][:default_config]
    @application.update(application_params)
    respond_with(@application)
  end

  private

  def application_params
    params.require(:application).permit(:name, :description, :oauth_key, :oauth_secret)
  end

end
