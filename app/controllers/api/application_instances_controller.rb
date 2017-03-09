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

    # Strong params doesn't allow arbitrary json to be permitted
    # So we have to explicitly set the config
    # This will be allowed in rails 5.1
    @application_instance.config = params[:application_instance][:config]

    @application_instance.save!
    render json: @application_instance.as_json(include: :site)
  end

  def update
    # Strong params doesn't allow arbitrary json to be permitted
    # So we have to explicitly set the config
    # This will be allowed in rails 5.1
    @application_instance.config = params[:application_instance][:config]
    @application_instance.update(application_instance_params)
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
      :lti_type,
    )
  end

end
