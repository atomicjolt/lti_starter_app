class Api::ApplicationInstancesController < Api::ApiApplicationController

  load_and_authorize_resource :application
  load_and_authorize_resource :application_instance, through: :application

  before_action :set_configs, only: [:create, :update]

  def index
    application_instances = @application_instances.map do |app|
      app_json = app.as_json(include: :site)
      app_json["lti_config_xml"] = app.lti_config_xml
      app_json["canvas_token_preview"] = app.canvas_token_preview
      app_json.delete("encrypted_canvas_token")
      app_json.delete("encrypted_canvas_token_salt")
      app_json.delete("encrypted_canvas_token_iv")
      app_json
    end

    render json: application_instances
  end

  def show
    respond_with_json
  end

  def create
    @application_instance.save!
    respond_with_json
  end

  def update
    @application_instance.update(application_instance_params)
    respond_with_json
  end

  def destroy
    @application_instance.destroy
    render json: { head: :ok }
  end

  private

  def set_configs
    # Strong params doesn't allow arbitrary json to be permitted
    # So we have to explicitly set the config
    # This will be allowed in rails 5.1
    @application_instance.config = params[:application_instance][:config]
    @application_instance.lti_config = params[:application_instance][:lti_config]
  end

  def respond_with_json
    application_instance = @application_instance.as_json(include: :site)
    application_instance["lti_config_xml"] = @application_instance.lti_config_xml
    application_instance["canvas_token_preview"] = @application_instance.canvas_token_preview
    application_instance.delete("encrypted_canvas_token")
    application_instance.delete("encrypted_canvas_token_salt")
    application_instance.delete("encrypted_canvas_token_iv")
    render json: application_instance
  end

  def application_instance_params
    params.require(:application_instance).permit(
      :site_id,
      :lti_secret,
      :canvas_token,
      :lti_key,
      :disabled_at,
    )
  end

end
