class Site < ActiveRecord::Base
  has_many :application_instances

  validates :url, presence: true, uniqueness: true

  before_save :fix_url

  has_secure_token :secret

  def subdomain
    host = URI.parse(url).hostname
    host ? host.split(".").first : nil
  end

  def fix_url
    parsed = URI.parse(url)
    host = parsed.host
    scheme = parsed.scheme
    self.url = host ? "#{scheme}://#{host}" : nil
  end

end
