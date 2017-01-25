class Api::JwtsController < Api::ApiApplicationController

  def show
    token = AuthToken.issue_token({ user_id: current_user.id })
    respond_to do |format|
      format.json { render json: { jwt: token } }
    end
  end

end
