class CanvasCourse < ApplicationRecord
  has_many :authentications, inverse_of: :canvas_course, dependent: :nullify
end
