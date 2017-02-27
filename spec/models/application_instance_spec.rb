require "rails_helper"

RSpec.describe ApplicationInstance, type: :model do
  describe "create application" do
    before :each do
      @site = FactoryGirl.create(:site)
      @name = "test"
      @application = FactoryGirl.create(:application, name: @name)
    end

    it "sets a default lti key" do
      @application_instance = described_class.create!(site: @site, application: @application)
      expect(@application_instance.lti_key).to eq(@name)
    end

    it "sets a default secret" do
      @application_instance = described_class.create!(site: @site, application: @application)
      expect(@application_instance.lti_secret).to be_present
    end

    it "sets a default tenant to the lti_key" do
      @application_instance = described_class.create!(site: @site, application: @application)
      expect(@application_instance.tenant).to eq(@application_instance.lti_key)
    end

    it "doesn't change the tenant" do
      @application_instance = described_class.create!(
        site: @site,
        application: @application,
        tenant: "bfcoder",
      )
      expect(@application_instance.tenant).to_not eq(@application_instance.lti_key)
      expect(@application_instance.tenant).to eq("bfcoder")
    end

    it "sets a valid lti_key using the name" do
      name = "A Test"
      application = FactoryGirl.create(:application, name: name)
      @application_instance = described_class.create!(site: @site, application: application)
      expect(@application_instance.lti_key).to eq("a-test")
    end

    it "doesn't set lti_key if the lti_key is already set" do
      lti_key = "the-lti-key"
      @application_instance = described_class.create!(
        site: @site,
        lti_key: lti_key,
      )
      expect(@application_instance.lti_key).to eq(lti_key)
    end

    it "requires a site" do
      expect do
        described_class.create!(lti_key: "test")
      end.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "sets the lti_type to basic if no value is set" do
      @application_instance = described_class.create!(lti_key: "test", site: @site)
      expect(@application_instance.basic?).to be true
    end

    it "creates a schema upon creation" do
      TestAfterCommit.with_commits(true) do
        expect(Apartment::Tenant).to receive(:create)
        @application_instance = create :application_instance
      end
    end

    it "does not allow the name to be changed after creation" do
      @application_instance = FactoryGirl.create(:application_instance)
      @application_instance.lti_key = "new-lti-key"
      expect(@application_instance.valid?).to be false
    end
  end
end
