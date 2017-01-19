class Api::InstancesController < ApplicationController
  include Concerns::JwtToken

  before_action :authenticate_user!
  before_action :only_admins!
  before_action :validate_token

  def index
    applications = ApplicationInstance.where(application_id: params[:lti_application_id])
    render json: applications
  end

  private

  def only_admins!
    user_not_authorized unless current_user.admin?
  end
end
