class Api::CanvasAccountsController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  before_action :protect_canvas_api

  def index
    result = canvas_api.all_accounts
    render json: { accounts: result }
  end
end
