class JwksController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Jwk.last.to_json }
    end
  end
end
