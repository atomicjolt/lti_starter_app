class LtiConfigsController < ApplicationController
  def show
    respond_to do |format|
      format.json { render json: current_application_instance.lti_advantage_config_json }
    end
  end
end
