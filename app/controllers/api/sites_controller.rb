class Api::SitesController < Api::ApiApplicationController

  load_and_authorize_resource :site

  def index
    render status: 200, json: @sites
  end

end
