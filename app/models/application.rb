class Application < ActiveRecord::Base
  include LtiModelSupport

  serialize :default_config, HashSerializer

  has_many :application_instances
  validates :name, presence: true, uniqueness: true

  before_validation :set_lti

  has_many :application_bundles
  has_many :bundles, through: :application_bundles

  # example store_accessor for default_config
  # This allows access to instance.default_config[:foo] like instance.foo
  # Or instance.bar
  # If foo is not set in the default_config json, it will return nil
  # store_accessor :default_config, :foo, :bar

  enum kind: [:lti, :admin]

  private

  def set_lti
    self.visibility ||= Application.visibility[:everyone]
    self.lti_type ||= Application.lti_types[:basic]
  end

end
