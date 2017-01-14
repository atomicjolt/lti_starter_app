class Application < ActiveRecord::Base

  has_many :application_instances
  validates :name, presence: true
  validates :name, uniqueness: true

  enum kind: [:lti, :admin]
end
