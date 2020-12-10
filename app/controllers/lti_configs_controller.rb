class LtiConfigsController < ApplicationController
  def show
    respond_to do |format|
      format.json { render json: current_application.lti_advantage_config_json }
    end
  end
end
