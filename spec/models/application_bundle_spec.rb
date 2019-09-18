require "rails_helper"

RSpec.describe ApplicationBundle, type: :model do
  it "creates an application bundle" do
    application = FactoryBot.create(:application)
    bundle = FactoryBot.create(:bundle)
    application_bundle = ApplicationBundle.create!(
      application: application,
      bundle: bundle,
    )
    expect(application_bundle).to be
  end
end
