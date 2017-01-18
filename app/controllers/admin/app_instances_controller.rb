class Admin::AppInstancesController < ApplicationController

  before_action :authenticate_user!
  before_action :only_admins!

  def index
    applications = ApplicationInstance.where(application_id: params[:application_id])
    render json: applications
  end

  private

  def only_admins!
    user_not_authorized unless current_user.admin?
  end
end
