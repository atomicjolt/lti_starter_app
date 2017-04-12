require "rails_helper"

RSpec.describe Site, type: :model do
  describe "valid?" do
    it "is true when url is unique" do
      url = "asdf1234"
      site = create(:site, url: url)
      expect(site.valid?).to be true
    end

    it "is false for duplicate url" do
      url = "asdf1234"
      create(:site, url: url)
      site = build(:site, url: url)
      expect(site.valid?(url)).to be false
    end

    it "is false when url is missing" do
      url = nil
      site = build(:site, url: url)
      expect(site.valid?).to be false
    end
  end
end
