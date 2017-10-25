require "rails_helper"

describe ApplicationController, type: :controller do
  controller do
    include Concerns::JwtToken

    before_action :validate_token
    respond_to :json

    def index
      render plain: "User: #{@user.display_name}"
    end
  end

  context "no authorization header" do
    it "should not be authorized" do
      get :index, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "invalid authorization header" do
    it "should not be authorized" do
      request.headers["Authorization"] = "A fake header"
      get :index, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "valid authorization header" do
    before do
      @user = FactoryGirl.create(:user)
      @user.confirm
      @user_token = AuthToken.issue_token({ user_id: @user.id })
      request.headers["Authorization"] = @user_token
    end
    it "should be authorized" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "jwt_token" do
    it "generates a new jwt token" do
      controller.class.instance_eval do
        define_method(:canvas_url) { "https://atomicjolt.instructure.com" }
      end
      expect(controller).to receive("signed_in?").and_return(true)
      expect(controller).to receive(:current_user).and_return(double(id: 1))
      result = controller.jwt_token
      expect(result).to be
    end
  end
end
