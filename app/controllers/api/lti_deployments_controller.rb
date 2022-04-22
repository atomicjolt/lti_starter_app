class Api::LtiDeploymentsController < Api::ApiApplicationController
  load_and_authorize_resource :application_instance
  load_and_authorize_resource :lti_deployment, through: :application_instance, parent: false

  def index
    per_page = 100
    @lti_deployments = @lti_deployments.
      order(created_at: :desc).
      paginate(page: params[:page], per_page: per_page)
    lti_deployments_json = @lti_deployments.map do |lti_deployment|
      json_for(lti_deployment)
    end
    render json: {
      lti_deployment_keys: lti_deployments_json,
      total_pages: @lti_deployments.total_pages,
      per_page: per_page,
    }
  end

  def show
    respond_with_json
  end

  def create
    @lti_deployment.save!
    respond_with_json
  end

  def update
    @lti_deployment.update(lti_deployment_params)
    respond_with_json
  end

  def destroy
    @lti_deployment.destroy
    render json: { head: :ok }
  end

  private

  def respond_with_json
    @lti_deployments = [@lti_deployment]
    render json: json_for(@lti_deployment)
  end

  def json_for(lti_deployment)
    lti_deployment.as_json
  end

  def lti_deployment_params
    params.require(:lti_deployment).permit(
      :deployment_id,
      :lti_install_id,
    )
  end

end
