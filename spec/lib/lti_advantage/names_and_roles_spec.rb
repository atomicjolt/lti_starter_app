require "rails_helper"

RSpec.describe LtiAdvantage::Services::NamesAndRoles do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
    @lti_token = LtiAdvantage::Authorization.validate_token(@application_instance, @params["id_token"])
  end

  describe "valid?" do
    it "indicates if the launch contains the names and roles scope" do
      names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)
      expect(names_and_roles_service.valid?).to eq true
    end
  end

  describe "list" do
    it "lists users in the course and their roles" do
      names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)
      names_and_roles = names_and_roles_service.list
    end
  end
end
