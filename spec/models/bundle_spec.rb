require "rails_helper"

RSpec.describe Bundle, type: :model do
  it "creates an application bundle" do
    key = "test"
    bundle = Bundle.create!(key: key)
    expect(bundle).to be
  end

  it "finds bundles by application id" do
    key = "test"
    bundle = Bundle.create!(key: key)
    attrs = FactoryBot.attributes_for(:application)
    application = bundle.applications.create!(attrs)
    bundles = Bundle.includes(:applications).by_application_id(application.id)
    expect(bundles.first.id).to eq(bundle.id)
  end
end
