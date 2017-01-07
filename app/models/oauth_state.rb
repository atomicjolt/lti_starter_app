class OauthState < ActiveRecord::Base
  validates :state, presence: true
  validates :state, uniqueness: true
end
