FactoryBot.define do
  factory :ims_import do
    status { "initialized" }
    error_message { nil }
    error_trace { nil }
    export_token { FactoryBot.generate(:uuid) }
    context_id { FactoryBot.generate(:context_id) }
    tci_guid { FactoryBot.generate(:context_id) }
    lms_course_id { FactoryBot.generate(:lms_course_id) }
    source_context_id { FactoryBot.generate(:context_id) }
    source_tci_guid { FactoryBot.generate(:context_id) }
  end
end
