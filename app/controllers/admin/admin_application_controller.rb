class Admin::AdminApplicationController < ApplicationController

  before_action :authenticate_user!
  before_action :only_admins!

  private

  def only_admins!
    user_not_authorized unless current_user.admin?
  end

end
