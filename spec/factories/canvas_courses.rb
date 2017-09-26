FactoryGirl.define do
  factory :canvas_course do
    lms_course_id { generate(:lms_course_id) }
  end
end
