require "lms_api"

Rails.application.config.to_prepare do
  LMS::Canvas.auth_state_model = Authentication
end
