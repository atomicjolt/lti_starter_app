class LtiApplication < ActiveRecord::Base

  has_many :lti_application_instances
  validates :name, presence: true
  validates :name, uniqueness: true

end
