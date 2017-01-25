class Api::ApplicationInstancesController < Api::ApiApplicationController

  load_and_authorize_resource :application
  load_and_authorize_resource :application_instance, through: :application

  def index
    @application_instances = @application_instances
    render json: @application_instances.as_json(include: :site)
  end

  def create
    render json: @application_instance
  end

  def destroy
    @application_instance.destroy
    render json: { head: :ok }
  end

  private

  def application_instance_params
    params.require(:application_instance).permit(:name)
  end

end
