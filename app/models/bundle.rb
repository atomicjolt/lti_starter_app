class Bundle < ApplicationRecord
  has_many :application_bundles
  has_many :applications, through: :application_bundles
end
