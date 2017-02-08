class Admin::CanvasAuthenticationsController < ApplicationController
  respond_to :html

  def create
    canvas_url = params[:canvas_url]

    if canvas_url.blank?
      flash[:error] = "Please provide the url for your Canvas installation"
      redirect_to admin_lti_installs_path
      return
    end

    begin
      canvas_url = URI.parse(canvas_url)
      canvas_url = URI.parse("https://#{canvas_url}") if !canvas_url.scheme
      canvas_url.scheme = "https" if canvas_url.scheme != "https"
      session[:canvas_url] = canvas_url.to_s
      canvas_url.path  = ""
      canvas_url.query = nil
      redirect_to user_canvas_omniauth_authorize_path(canvas_url: canvas_url.to_s)
    rescue => ex
      flash[:error] = "We couldn't use the url you provided. Please check the url and try again. Error: #{ex}"
      redirect_to admin_lti_installs_path
    end
  end

end
