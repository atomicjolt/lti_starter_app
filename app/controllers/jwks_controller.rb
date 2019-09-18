class JwksController < ApplicationController
  def index
    respond_to do |format|
      # Map is required or the outer to_json will show your private keys to the world
      format.json { render json: { keys: current_application.jwks.map(&:to_json) }.to_json }
    end
  end
end
