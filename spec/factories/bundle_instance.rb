FactoryGirl.define do
  factory :bundle_instance do
    bundle { FactoryGirl.create(:application_bundle).bundle }
    site
  end
end
