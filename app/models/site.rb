class Site < ActiveRecord::Base
  has_many :application_instances

  validates :url, presence: true
  validates :url, uniqueness: true
end
