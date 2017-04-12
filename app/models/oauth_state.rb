class OauthState < ActiveRecord::Base
  validates :state, presence: true, uniqueness: true
end
