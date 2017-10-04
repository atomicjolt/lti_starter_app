class CanvasCourse < ApplicationRecord
  has_many :authentications, dependent: :destroy, inverse_of: :canvas_course
end
