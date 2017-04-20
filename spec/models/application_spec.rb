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
end
