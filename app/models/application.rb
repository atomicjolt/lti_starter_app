class Application < ActiveRecord::Base

  has_many :application_instances
  validates :name, presence: true, uniqueness: true

  enum kind: [:lti, :admin]
end
