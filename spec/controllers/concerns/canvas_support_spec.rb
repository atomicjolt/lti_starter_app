require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    @app = FactoryGirl.create(:application_instance)
    allow(controller).to receive(:current_application_instance).and_return(@app)
    allow(Application).to receive(:find_by).with(:lti_key).and_return(@app)
  end

  controller do
    include Concerns::CanvasSupport

    before_action :protect_canvas_api

    def index
      result = canvas_api.proxy(params[:type], params.to_unsafe_h, request.body.read)
      response.status = result.code

      render plain: result.body
    end
  end

  it "provides access to the canvas api" do
    get :index, params: { lti_key: @app.lti_key, type: "LIST_ACCOUNTS" }, format: :json
    expect(response).to have_http_status(:success)
  end

  it "doesn't allow access to unauthorized API endpoints" do
    get :index, params: { lti_key: @app.lti_key, type: "LIST_ACCOUNTS_FOR_COURSE_ADMINS" }, format: :json
    expect(response).to have_http_status(:unauthorized)
  end
end
