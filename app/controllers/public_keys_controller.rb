class PublicKeysController < ApplicationController
  def index
    render plain: current_application.current_jwk.private_key.public_key.to_pem
  end
end
