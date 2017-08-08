require "rails_helper"

RSpec.describe BundleInstance, type: :model do
  describe "entity_key" do
    it "should fix entity_key before_save" do
      subject = BundleInstance.new(entity_key: "https://example.com")
      subject.save
      expect(subject.entity_key).to eq("example.com")
    end
  end
end
