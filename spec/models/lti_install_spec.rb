require "rails_helper"

RSpec.describe LtiInstall, type: :model do
  describe "validations" do
    it "validates presence of the client id" do
      application = FactoryBot.create(:application)
      lti_install = LtiInstall.create(application: application)
      expect(lti_install.valid?).to be false
    end

    it "validates presence of the application" do
      lti_install = LtiInstall.create(client_id: "1234")
      expect(lti_install.valid?).to be false
    end

    it "passes validation" do
      application = FactoryBot.create(:application)
      lti_install = LtiInstall.create(application: application, client_id: "1234")
      expect(lti_install.valid?).to be true
    end
  end
end
