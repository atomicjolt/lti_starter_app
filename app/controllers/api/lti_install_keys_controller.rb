class Api::LtiInstallKeysController < Api::ApiApplicationController
  load_and_authorize_resource :application
  load_and_authorize_resource :lti_install, through: :application, parent: false

  def index
    @lti_installs = @lti_installs.
      order(sort_column.to_sym => sort_direction.to_sym).
      paginate(page: params[:page], per_page: 30)
    lti_installs_json = @lti_installs.map do |lti_install|
      json_for(lti_install)
    end
    render json: {
      lti_install_keys: lti_installs_json,
      total_pages: @lti_installs.total_pages,
    }
  end

  def show
    respond_with_json
  end

  def create
    @lti_install.save!
    respond_with_json
  end

  def update
    @lti_install.update(lti_install_params)
    respond_with_json
  end

  def destroy
    @lti_install.destroy
    render json: { head: :ok }
  end

  private

  def sortable_columns
    [
      "created_at",
      "iss",
      "client_id",
      "jwks_url",
      "token_url",
      "oidc_url",
    ]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def respond_with_json
    @lti_installs = [@lti_install]
    render json: json_for(@lti_install)
  end

  def json_for(lti_install)
    json = lti_install.as_json
    json
  end

  def lti_install_params
    params.require(:lti_install).permit(
      :iss,
      :client_id,
      :jwks_url,
      :token_url,
      :oidc_url,
    )
  end

end
