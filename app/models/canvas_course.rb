class CanvasCourse < ApplicationRecord
  has_many :authentications, dependent: :destroy, inverse_of: :canvas_course

  def self.create_on_tenant(tenant, course_id)
    Apartment::Tenant.switch(tenant) do
      CanvasCourse.find_or_create_by(
        lms_course_id: course_id,
      )
    end
  end
end
