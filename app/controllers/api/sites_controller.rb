class Api::SitesController < Api::ApiApplicationController

  load_and_authorize_resource :site

  def index
    render status: 200, json: @sites
  end

  def create
    @site.save!
    render status: 200, json: @site
  end

  private

  def site_params
    params.require(:site).permit(:url, :oauth_key, :oauth_secret)
  end

end
