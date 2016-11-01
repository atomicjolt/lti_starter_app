require 'rails_helper'

RSpec.describe LtiApplicationInstance, type: :model do

  describe "create lti application" do
    before do
      @lti_consumer_uri = "example.com"
      @name = "test"
      @lti_application = FactoryGirl.create(:lti_application, name: @name)
    end

    it "sets a default lti key" do
      app = described_class.create!(lti_consumer_uri: @lti_consumer_uri, lti_application: @lti_application)
      expect(app.lti_key).to eq(@name)
    end

    it "sets a default secret" do
      app = described_class.create!(lti_consumer_uri: @lti_consumer_uri, lti_application: @lti_application)
      expect(app.lti_secret).to be_present
    end

    it "sets a valid lti_key using the name" do
      name = "A Test"
      lti_application = FactoryGirl.create(:lti_application, name: name)
      app = described_class.create!(lti_consumer_uri: @lti_consumer_uri, lti_application: lti_application)
      expect(app.lti_key).to eq("a-test")
    end

    it "doesn't set lti_key if the lti_key is already set" do
      lti_key = "the-lti-key"
      app = described_class.create!(
        lti_consumer_uri: @lti_consumer_uri,
        lti_key: lti_key
      )
      expect(app.lti_key).to eq(lti_key)
    end

    it "requires a lti_consumer_uri" do
      expect {
        described_class.create!(lti_key: "test")
      }.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "sets the lti_type to basic if no value is set" do
      app = described_class.create!(lti_key: "test", lti_consumer_uri: @lti_consumer_uri)
      expect(app.basic?).to be true
    end

  end

end
