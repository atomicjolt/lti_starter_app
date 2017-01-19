class Api::CanvasAccountsController < ApplicationController

  include Concerns::CanvasSupport
  include Concerns::JwtToken

  before_action :validate_token
  before_action :protect_canvas_api

  respond_to :json

  def index
    result = canvas_api.all_accounts
    render json: { accounts: result }
  end
end
