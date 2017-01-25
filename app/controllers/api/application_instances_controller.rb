class Api::ApplicationInstancesController < Api::ApiApplicationController

  load_and_authorize_resource :application
  load_and_authorize_resource :application_instance, through: :application, param_method: :param_sanitizer

  def index
    @application_instances = @application_instances.include(:site)
    render json: @application_instances
  end

  private

  def param_sanitizer
    params.require(:application_instance).permit(:name)
  end

end
