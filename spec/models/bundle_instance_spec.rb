require "rails_helper"

RSpec.describe BundleInstance, type: :model do
  describe "entity_key" do
    it "should fix entity_key before_save" do
      bundle = Bundle.create!(key: SecureRandom.uuid)
      site = Site.create!(url: "https://bundle.example.com")
      subject = BundleInstance.new(
        entity_key: "https://example.com",
        bundle: bundle,
        site: site,
      )
      subject.save!
      expect(subject.entity_key).to eq("example.com")
    end
  end
end
