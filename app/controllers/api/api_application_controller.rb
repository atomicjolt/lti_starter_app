class Api::ApiApplicationController < ApplicationController
  include Concerns::JwtToken
  before_action :validate_token
  respond_to :json
end
