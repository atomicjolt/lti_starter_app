class Application < ActiveRecord::Base
  serialize :default_config, HashSerializer

  has_many :application_instances
  validates :name, presence: true, uniqueness: true

  # example store_accessor for default_config
  # This allows access to instance.default_config[:foo] like instance.foo
  # Or instance.bar
  # If foo is not set in the default_config json, it will return nil
  # store_accessor :default_config, :foo, :bar
  store_accessor :default_config, :visibility

  enum kind: [:lti, :admin]
end
