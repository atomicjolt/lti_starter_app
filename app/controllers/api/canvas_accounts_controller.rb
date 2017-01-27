class Api::CanvasAccountsController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  authorize_resource class: false

  def index
    result = canvas_api.all_accounts
    render json: { accounts: result }
  end
end
