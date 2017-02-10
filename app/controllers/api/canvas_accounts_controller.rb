class Api::CanvasAccountsController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  authorize_resource class: false

  def index
    accounts = canvas_api.proxy("LIST_ACCOUNTS", {}, nil, true).map do |account|
      account["sub_accounts"] = canvas_api.proxy(
        "GET_SUB_ACCOUNTS_OF_ACCOUNT",
        { account_id: account["id"] },
        nil,
        true,
      )

      account
    end

    render json: accounts
  end
end
