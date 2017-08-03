require "rails_helper"

RSpec.describe Site, type: :model do
  describe "valid?" do
    it "is true when url is unique" do
      url = "https://example.com"
      site = create(:site, url: url)
      expect(site.valid?).to be true
    end

    it "is false for duplicate url" do
      url = "https://example.com"
      create(:site, url: url)
      site = build(:site, url: url)
      expect(site.valid?(url)).to be false
    end

    it "is false for duplicate url with trailing slash" do
      url = "https://example.com"
      create(:site, url: url)
      url = "https://example.com/"
      site = create(:site, url: url)
      expect(site.valid?(url)).to be false
    end

    it "is false when url is missing" do
      url = nil
      site = build(:site, url: url)
      expect(site.valid?).to be false
    end

    describe "key" do
      it "handles vanity subdomains" do
        site = build(:site, url: "https://my.cool.canvas.domain.com")
        expect(site.key).to eq("my_cool_canvas_domain_com")
      end

      it "handles .instructure.com domains" do
        site = build(:site, url: "https://my.cool.school.instructure.com")
        expect(site.key).to eq("my_cool_school")
      end
    end
  end
end
