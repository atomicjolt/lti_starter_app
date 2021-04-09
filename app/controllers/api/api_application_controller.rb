class Api::ApiApplicationController < ApplicationController
  include JwtToken
  before_action :validate_token
  skip_before_action :verify_authenticity_token
  respond_to :json
end
