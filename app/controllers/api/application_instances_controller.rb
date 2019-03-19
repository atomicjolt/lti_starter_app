class Api::ApplicationInstancesController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  load_and_authorize_resource :application
  load_and_authorize_resource :application_instance, through: :application

  before_action :set_configs, only: [:create, :update]

  def index
    @application_instances = @application_instances.
      by_oldest.
      paginate(page: params[:page], per_page: 30)
    set_requests
    application_instances = @application_instances.map do |app_inst|
      authentications = get_authentications(app_inst)
      app_inst_json = app_inst.as_json(include: :site)
      app_inst_json["lti_config_xml"] = app_inst.lti_config_xml
      app_inst_json["canvas_token_preview"] = app_inst.canvas_token_preview
      app_inst_json["authentications"] = authentications
      app_inst_json["request_stats"] = request_stats(app_inst.tenant)
      app_inst_json.delete("encrypted_canvas_token")
      app_inst_json.delete("encrypted_canvas_token_salt")
      app_inst_json.delete("encrypted_canvas_token_iv")
      app_inst_json
    end
    render json: {
      application_instances: application_instances,
      total_pages: @application_instances.total_pages,
    }
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

  def check_auth
    site = @application_instance.site
    url = UrlHelper.scheme_host_port(site.url)
    Apartment::Tenant.switch(@application_instance.tenant) do
      auth = @application_instance.authentications.find(params[:authentication_id])
      api = Integrations::CanvasApiSupport.refreshable_auth(auth, url, site)
      if accounts = api.proxy("LIST_ACCOUNTS", {}, {}, true)
        render json: accounts
      else
        render json: []
      end
    end
  end

  private

  def get_authentications(application_instance_instance)
    Apartment::Tenant.switch(application_instance_instance.tenant) do
      application_instance_instance.authentications.map do |authentication|
        {
          id: authentication.id,
          user: authentication.user&.display_name,
          email: authentication.user&.email,
          provider: authentication.provider,
          created_at: authentication.created_at,
        }
      end
    end
  end

  def set_configs
    # Strong params doesn't allow arbitrary json to be permitted
    # So we have to explicitly set the config
    # This will be allowed in rails 5.1
    @application_instance.config = params[:application_instance][:config]
    @application_instance.lti_config = params[:application_instance][:lti_config]
  end

  def respond_with_json
    authentications = get_authentications(@application_instance)
    application_instance = @application_instance.as_json(include: :site)
    application_instance["lti_config_xml"] = @application_instance.lti_config_xml
    application_instance["canvas_token_preview"] = @application_instance.canvas_token_preview
    application_instance.delete("encrypted_canvas_token")
    application_instance.delete("encrypted_canvas_token_salt")
    application_instance.delete("encrypted_canvas_token_iv")
    application_instance["authentications"] = authentications
    render json: application_instance
  end

  def set_requests
    tenants = @application_instances.pluck(:tenant)
    @day_1_requests_grouped, @day_7_requests_grouped, @day_30_requests_grouped =
      RequestLog.total_requests_grouped(tenants)
    @day_1_launches_grouped, @day_7_launches_grouped, @day_30_launches_grouped =
      RequestLog.total_lti_launches_grouped(tenants)
    @day_1_errors_grouped, @day_7_errors_grouped, @day_30_errors_grouped =
      RequestLog.total_errors_grouped(tenants)
    @day_1_users_grouped, @day_7_users_grouped, @day_30_users_grouped =
      RequestLog.total_unique_users_grouped(tenants)
  end

  def request_stats(tenant)
    {
      day_1_requests: day_1_requests_grouped(tenant),
      day_7_requests: day_7_requests_grouped(tenant),
      day_30_requests: day_30_requests_grouped(tenant),
      day_1_users: day_1_users_grouped(tenant),
      day_7_users: day_7_users_grouped(tenant),
      day_30_users: day_30_users_grouped(tenant),
      day_1_launches: day_1_launches_grouped(tenant),
      day_7_launches: day_7_launches_grouped(tenant),
      day_30_launches: day_30_launches_grouped(tenant),
      day_1_errors: day_1_errors_grouped(tenant),
      day_7_errors: day_7_errors_grouped(tenant),
      day_30_errors: day_30_errors_grouped(tenant),
    }
  end

  def day_1_requests_grouped(tenant)
    @day_1_requests_grouped[tenant.to_s] || 0
  end

  def day_7_requests_grouped(tenant)
    @day_7_requests_grouped[tenant.to_s] || 0
  end

  def day_30_requests_grouped(tenant)
    @day_30_requests_grouped[tenant.to_s] || 0
  end

  def day_1_users_grouped(tenant)
    @day_1_users_grouped[tenant.to_s] || 0
  end

  def day_7_users_grouped(tenant)
    @day_7_users_grouped[tenant.to_s] || 0
  end

  def day_30_users_grouped(tenant)
    @day_30_users_grouped[tenant.to_s] || 0
  end

  def day_1_launches_grouped(tenant)
    @day_1_launches_grouped[tenant.to_s] || 0
  end

  def day_7_launches_grouped(tenant)
    @day_7_launches_grouped[tenant.to_s] || 0
  end

  def day_30_launches_grouped(tenant)
    @day_30_launches_grouped[tenant.to_s] || 0
  end

  def day_1_errors_grouped(tenant)
    @day_1_errors_grouped[tenant.to_s] || 0
  end

  def day_7_errors_grouped(tenant)
    @day_7_errors_grouped[tenant.to_s] || 0
  end

  def day_30_errors_grouped(tenant)
    @day_30_errors_grouped[tenant.to_s] || 0
  end

  def application_instance_params
    params.require(:application_instance).permit(
      :site_id,
      :lti_secret,
      :canvas_token,
      :lti_key,
      :disabled_at,
      :anonymous,
      :domain,
    )
  end

end
