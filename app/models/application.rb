class Application < ActiveRecord::Base

  serialize :default_config, HashSerializer
  serialize :lti_config, HashSerializer
  serialize :canvas_api_permissions, HashSerializer

  has_many :application_instances
  validates :name, presence: true, uniqueness: true

  has_many :application_bundles
  has_many :bundles, through: :application_bundles

  # example store_accessor for default_config
  # This allows access to instance.default_config[:foo] like instance.foo
  # Or instance.bar
  # If foo is not set in the default_config json, it will return nil
  # store_accessor :default_config, :foo, :bar

  # Kinds of Applications
  # lti: LTI tools. It's possible that these are also stand alone apps that
  #                 can be used outside of an LTI launch
  # admin: The admin tool
  # app: Stand alone applications that don't require an lti launch
  enum kind: %i{lti admin app}
end
