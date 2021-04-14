require "rails_helper"

describe ApplicationController, type: :controller do
  controller do
    include JwtToken

    before_action :validate_token
    respond_to :json

    def index
      render plain: "User: #{@user.display_name}"
    end
  end

  before do
    setup_application_instance
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
      @user = FactoryBot.create(:user)
      @user.confirm
      @user_token = AuthToken.issue_token(
        {
          application_instance_id: @application_instance.id,
          user_id: @user.id,
        },
      )
      request.headers["Authorization"] = @user_token
    end
    it "should be authorized" do
      user = FactoryBot.create(:user)
      user.confirm
      user_token = AuthToken.issue_token(
        {
          application_instance_id: @application_instance.id,
          user_id: @user.id,
        },
      )
      request.headers["Authorization"] = user_token
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "jwt_lti_roles_string" do
    before do
      @user = FactoryBot.create(:user_canvas)
      @user.confirm
      @user_token = AuthToken.issue_token(
        {
          application_instance_id: @application_instance.id,
          user_id: @user.id,
          lti_roles: @user.roles.map(&:name),
        },
      )
      request.headers["Authorization"] = "Bearer #{@user_token}"
    end

    it "should handle nil roles" do
      ## User factory does not include any roles
      @user_token = AuthToken.issue_token(
        {
          application_instance_id: @application_instance.id,
          user_id: @user.id,
        },
      )
      request.headers["Authorization"] = "Bearer #{@user_token}"
      expect(controller.jwt_lti_roles_string).to eq("")
    end

    it "should handle valid roles" do
      roles = controller.jwt_lti_roles
      expect(roles.empty?).to eq(false)
      expect(roles).to eq(@user.roles.map(&:name))
    end
  end

  describe "lti_admin?" do
    before do
      @user = FactoryBot.create(:user_canvas)
      @user.confirm
    end

    it "returns true for urn:lti:instrole:ims/lis/Administrator" do
      user_token = AuthToken.issue_token({ user_id: @user.id, lti_roles: ["urn:lti:instrole:ims/lis/Administrator"] })
      request.headers["Authorization"] = "Bearer #{user_token}"
      expect(controller.lti_admin?).to eq(true)
    end

    it "returns true for urn:lti:sysrole:ims/lis/SysAdmin" do
      user_token = AuthToken.issue_token({ user_id: @user.id, lti_roles: ["urn:lti:sysrole:ims/lis/SysAdmin"] })
      request.headers["Authorization"] = "Bearer #{user_token}"
      expect(controller.lti_admin?).to eq(true)
    end

    it "returns true for urn:lti:sysrole:ims/lis/Administrator" do
      user_token = AuthToken.issue_token({ user_id: @user.id, lti_roles: ["urn:lti:sysrole:ims/lis/Administrator"] })
      request.headers["Authorization"] = "Bearer #{user_token}"
      expect(controller.lti_admin?).to eq(true)
    end

    it "returns true for urn:lti:role:ims/lis/Administrator" do
      user_token = AuthToken.issue_token({ user_id: @user.id, lti_roles: ["urn:lti:role:ims/lis/Administrator"] })
      request.headers["Authorization"] = "Bearer #{user_token}"
      expect(controller.lti_admin?).to eq(true)
    end
  end
end
