class Admin::ApplicationInstanceController < ApplicationController

  before_action :authenticate_user!
  before_action :only_admins!

  def index
    byebug
    t=0
    applications = Application.all
  end

  private

    def only_admins!
      user_not_authorized unless current_user.admin?
    end
end
