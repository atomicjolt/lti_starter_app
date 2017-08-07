require "rails_helper"

RSpec.describe BundleInstance, type: :model do
  describe "entity_key_from_url" do
    it "should return key" do
      url = "http://sub.domain.example.com"
      result = BundleInstance.entity_key_from_url(url)
      expect(result).to eq("sub.domain.example.com")
    end
  end
end
