module LtiModelSupport
  extend ActiveSupport::Concern
  included do
    enum lti_type: [:basic, :course_navigation, :account_navigation, :wysiwyg_button]
    enum visibility: [:everyone, :admins, :members]
  end
end
