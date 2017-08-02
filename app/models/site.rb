class Site < ActiveRecord::Base
  has_many :application_instances

  validates :url, presence: true, uniqueness: true

  before_save :fix_url

  has_secure_token :secret

  def subdomain
    host = URI.parse(url).hostname
    host ? host.split(".").first : nil
  end

  def key
    host = URI.parse(url).hostname
    host
      .sub(".instructure.com", "")
      .sub(/![a-zA-Z0-9]/, '$')
  end

  def fix_url
    self.url = UrlHelper.scheme_host(url)
  end
end
