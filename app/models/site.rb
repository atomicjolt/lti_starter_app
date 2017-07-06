class Site < ActiveRecord::Base
  has_many :application_instances

  validates :url, presence: true, uniqueness: true

  has_secure_token :secret

  def subdomain
    URI.parse(url).hostname.split(".")[0]
  end

end
