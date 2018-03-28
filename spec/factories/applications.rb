FactoryBot.define do
  factory :application do
    name { FactoryBot.generate(:name) }
    key { FactoryBot.generate(:name) }
    canvas_api_permissions do
      {
        default: [
          "administrator", # Internal (non-LTI) role
          "urn:lti:sysrole:ims/lis/SysAdmin",
          "urn:lti:sysrole:ims/lis/Administrator",
        ],
        common: [],
        LIST_ACCOUNTS: [],
        LIST_ACCOUNT_ADMINS: [],
      }
    end
  end
end
