class Api::JwtsController < Api::ApiApplicationController

  def show
    old_token_attrs = decoded_jwt_token(request)&.except("iat", "exp", "aud")
    token = AuthToken.issue_token(old_token_attrs)
    respond_to do |format|
      format.json { render json: { jwt: token } }
    end
  end

end
