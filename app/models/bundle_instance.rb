class BundleInstance < ApplicationRecord
  belongs_to :bundle
  belongs_to :site
  has_many :application_instances
  has_many :applications, through: :bundle

  def create_application_instances
    bundle&.applications&.map do |app|
      app.create_instance(site: site, bundle_instance: self)
    end
  end
end
