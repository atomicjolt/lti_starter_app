require "rails_helper"

RSpec.describe Application, type: :model do
  describe "create application" do
    before do
      @consumer_uri = "example.com"
    end

    it "requires a name" do
      expect do
        described_class.create!(description: "a test")
      end.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end
end
