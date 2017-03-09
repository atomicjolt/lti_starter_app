class Application < ActiveRecord::Base
  serialize :default_config, HashSerializer

  has_many :application_instances
  validates :name, presence: true, uniqueness: true

  # example store_accessor for default_config
  store_accessor :default_config, :foo

  enum kind: [:lti, :admin]
end
