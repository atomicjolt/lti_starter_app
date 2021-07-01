class Api::ApplicationInstancesController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  load_and_authorize_resource :application
  load_and_authorize_resource :application_instance, through: :application

  before_action :set_configs, only: [:create, :update]

  def index
    @application_instances =
      if show_paid
        @application_instances.where.not(paid_at: nil)
      else
        @application_instances.where(paid_at: nil)
      end

    if search
      @application_instances = @application_instances.
        where("nickname ilike ? or lti_key ilike ?", "%#{search}%", "%#{search}%")
    end

    order_by =
      if sort_column === "nickname"
        "LOWER(#{sort_column}) #{sort_direction}"
      else
        { sort_column.to_sym => sort_direction.to_sym }
      end

    @application_instances = @application_instances.
      order(order_by).
      paginate(page: params[:page], per_page: 30)
    set_requests
    application_instances_json = @application_instances.map do |application_instance|
      json_for(application_instance)
    end
    render json: {
      application_instances: application_instances_json,
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
    tenant = @application_instance.tenant
    @application_instance.destroy
    Apartment::Tenant.drop(tenant)
    RequestStatistic.where(tenant: tenant).delete_all
    RequestUserStatistic.where(tenant: tenant).delete_all
    render json: { head: :ok }
  end

  def check_auth
    site = @application_instance.site
    url = UrlHelper.scheme_host_port(site.url)
    Apartment::Tenant.switch(@application_instance.tenant) do
      auth = @application_instance.authentications.find(params[:authentication_id])
      api = Integrations::CanvasApiSupport.refreshable_auth(auth, url, @application_instance)
      if accounts = api.proxy("LIST_ACCOUNTS", {}, {}, true)
        render json: accounts
      else
        render json: []
      end
    end
  end

  private

  def sortable_columns
    [
      "created_at",
      "trial_end_date",
      "nickname",
    ]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def show_paid
    params[:show_paid] == "true"
  end

  def search
    params[:search]
  end

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
    @application_instances = [@application_instance]
    set_requests
    render json: json_for(@application_instance)
  end

  def json_for(application_instance)
    authentications = get_authentications(application_instance)
    json = application_instance.as_json(include: :site)
    json["lti_config_xml"] = application_instance.lti_config_xml
    json["canvas_token_preview"] = application_instance.canvas_token_preview
    json.delete("encrypted_canvas_token")
    json.delete("encrypted_canvas_token_salt")
    json.delete("encrypted_canvas_token_iv")
    json["authentications"] = authentications
    json["request_stats"] = request_stats(application_instance.tenant)
    json["free_trial_days_left"] = free_trial_days_left(application_instance)
    json
  end

  def set_requests
    tenants = @application_instances.pluck(:tenant)
    @stats = {
      errors: RequestStatistic.total_errors_grouped(tenants),
    }
  end

  def stats(type, days_index, tenant)
    @stats[type][days_index][tenant.to_s] || 0
  end

  def request_stats(tenant)
    {
      day_1_errors: stats(:errors, 0, tenant),
      day_7_errors: stats(:errors, 1, tenant),
    }
  end

  def application_instance_params
    params.require(:application_instance).permit(
      :site_id,
      :lti_secret,
      :canvas_token,
      :lti_key,
      :disabled_at,
      :anonymous,
      :rollbar_enabled,
      :paid_at,
      :domain,
      :use_scoped_developer_key,
      :language,
      :nickname,
      :primary_contact,
      :trial_notes,
      :trial_users,
      :trial_end_date,
      :trial_start_date,
      :license_notes,
      :licensed_users,
      :license_end_date,
    )
  end

end
