class BundleInstance < ApplicationRecord
  belongs_to :bundle
  belongs_to :site
  has_many :application_instances
  has_many :applications, through: :bundle
  has_secure_token :id_token
  before_save :fix_entity_key

  def self.entity_key_from_url(url)
    UrlHelper.host(url)
  end

  def create_application_instances
    bundle&.applications&.map do |app|
      app.create_instance(
        site: site,
        bundle_instance: self,
        tenant: bundle.shared_tenant ? tenant : nil,
      )
    end
  end

  def fix_entity_key
    self.entity_key = BundleInstance.entity_key_from_url(entity_key)
  end

  def tenant
    "#{site.key}-#{bundle.key}"
  end
end
