require "rails_helper"

RSpec.describe ApplicationInstance, type: :model do

  describe "create application" do
    before :each do
      @lti_consumer_uri = "example.com"
      @name = "test"
      @application = FactoryGirl.create(:application, name: @name)
    end

    it "sets a default lti key" do
      @application_instance = described_class.create!(lti_consumer_uri: @lti_consumer_uri, application: @application)
      expect(@application_instance.lti_key).to eq(@name)
    end

    it "sets a default secret" do
      @application_instance = described_class.create!(lti_consumer_uri: @lti_consumer_uri, application: @application)
      expect(@application_instance.lti_secret).to be_present
    end

    it "sets a valid lti_key using the name" do
      name = "A Test"
      application = FactoryGirl.create(:application, name: name)
      @application_instance = described_class.create!(lti_consumer_uri: @lti_consumer_uri, application: application)
      expect(@application_instance.lti_key).to eq("a-test")
    end

    it "doesn't set lti_key if the lti_key is already set" do
      lti_key = "the-lti-key"
      @application_instance = described_class.create!(
        lti_consumer_uri: @lti_consumer_uri,
        lti_key: lti_key
      )
      expect(@application_instance.lti_key).to eq(lti_key)
    end

    it "requires a lti_consumer_uri" do
      expect {
        described_class.create!(lti_key: "test")
      }.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "sets the lti_type to basic if no value is set" do
      @application_instance = described_class.create!(lti_key: "test", lti_consumer_uri: @lti_consumer_uri)
      expect(@application_instance.basic?).to be true
    end

    it "creates a schema upon creation" do
      TestAfterCommit.with_commits(true) do
        expect(Apartment::Tenant).to receive(:create)
        @application_instance = create :application_instance
      end
    end

    it "deletes a schema upon deletion" do
      TestAfterCommit.with_commits(true) do
        expect(Apartment::Tenant).to receive(:create)
        expect(Apartment::Tenant).to receive(:drop)
        application_instance = create :application_instance
        application_instance.destroy
      end
    end

    it "does not allow the name to be changed after creation" do
      @application_instance = FactoryGirl.create(:application_instance)
      @application_instance.lti_key = "new-lti-key"
      expect(@application_instance.valid?).to be false
    end

  end

end
