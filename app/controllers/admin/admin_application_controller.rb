class Admin::AdminApplicationController < ApplicationController

  include Concerns::AdminSupport
  before_action :authenticate_user!

end
