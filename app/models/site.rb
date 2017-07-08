class Site < ActiveRecord::Base
  has_many :application_instances

  validates :url, presence: true, uniqueness: true

  has_secure_token :secret

  def subdomain
    host = URI.parse(url).hostname
    host ? host.split(".").first : nil
  end

end
