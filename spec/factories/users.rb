FactoryBot.define do
  factory :user do
    lms_user_id { FactoryBot.generate(:user_id) }
    name { FactoryBot.generate(:name) }
    email { FactoryBot.generate(:email) }
    password { FactoryBot.generate(:password) }
    lti_user_id { FactoryBot.generate(:uuid) }
    after(:build, &:confirm)
    after(:create) do |user|
      FactoryBot.create(:authentication, user_id: user.id, provider_url: FactoryBot.generate(:domain))
    end

    factory :user_with_avatar do
      avatar { File.open File.join(Rails.root, "spec", "fixtures", "avatar.jpg") }
    end

    factory :user_canvas do
      lti_provider { "canvas" }
      create_method { User.create_methods[:oauth] }
      after(:create) do |user|
        user.authentications << FactoryBot.create(:authentication_canvas)
        user.roles << FactoryBot.create(:role)
      end
    end

    factory :signed_up_user do
      create_method { "sign_up" }
    end
  end
end
