require "rails_helper"

RSpec.describe Application, type: :model do
  describe "valid?" do
    it "is true when name is unique" do
      name = "asdf1234"
      application = create(:application, name: name)
      expect(application.valid?).to be true
    end

    it "is false for duplicate name" do
      name = "asdf1234"
      create(:application, name: name)
      application = build(:application, name: name)
      expect(application.valid?(name)).to be false
    end

    it "is false when name is missing" do
      name = nil
      application = build(:application, name: name)
      expect(application.valid?).to be false
    end
  end

  describe "LtiInstall attribute getter methods" do
    let(:application) { FactoryBot.create(:application) }
    let(:iss) { FactoryBot.generate(:url) }
    let(:client_id) { FactoryBot.generate(:client_id) }
    let(:oidc_url) { FactoryBot.generate(:url) }
    let(:token_url) { FactoryBot.generate(:url) }
    let(:jwks_url) { FactoryBot.generate(:url) }

    before do
      @lti_install = FactoryBot.create(
        :lti_install,
        application: application,
        iss: iss,
        client_id: client_id,
        oidc_url: oidc_url,
        token_url: token_url,
        jwks_url: jwks_url,
      )

      FactoryBot.create(:lti_install, application: application, iss: iss)
    end

    describe "#oidc_url" do
      it "returns the correct oidc_url" do
        result = application.oidc_url(iss, client_id)

        expect(result).to eq(oidc_url)
      end
    end

    describe "#token_url" do
      it "returns the correct token_url" do
        result = application.token_url(iss, client_id)

        expect(result).to eq(token_url)
      end
    end

    describe "#jwks_url" do
      it "returns the correct jwks_url" do
        result = application.jwks_url(iss, client_id)

        expect(result).to eq(jwks_url)
      end
    end
  end
end
