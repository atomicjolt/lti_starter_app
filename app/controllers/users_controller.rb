class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  load_and_authorize_resource
  before_action :setup_will_paginate, only: %i[index]

  def index
    @users = @users.
      sign_up_user.
      by_email.
      paginate(page: @page, per_page: 10)
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to users_path, error: "User failed to successfully update." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      role_ids: [],
    )
  end

  def check_admin
    authorize! :manage, :all
  end
end
