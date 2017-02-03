class Api::ApplicationInstancesController < Api::ApiApplicationController

  load_and_authorize_resource :application
  load_and_authorize_resource :application_instance, through: :application

  def index
    application_instances = @application_instances.map do |app|
      app_json = app.as_json(include: :site)
      app_json["lti_config_xml"] = app.lti_config_xml
      app_json
    end

    render json: application_instances
  end

  def show
    application_instance = @application_instance.as_json(include: :site)
    application_instance["lti_config_xml"] = @application_instance.lti_config_xml
    render json: application_instance
  end

  def create
    @application_instance.domain =
      "#{@application_instance.lti_key}.#{ENV['APP_URL']}"

    @application_instance.save!
    render json: @application_instance.as_json(include: :site)
  end

  def destroy
    @application_instance.destroy
    render json: { head: :ok }
  end

  private

  def application_instance_params
    params.require(:application_instance).permit(
      :site_id,
      :lti_secret,
      :canvas_token,
      :lti_key,
      :lti_type
    )
  end

end
