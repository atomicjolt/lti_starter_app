class CreateCanvasCourses < ActiveRecord::Migration[5.0]
  def change
    unless table_exists? :canvas_courses
      create_table :canvas_courses do |t|
        t.bigint :lms_course_id

        t.timestamps
      end
      add_index :canvas_courses, :lms_course_id
    end
  end
end
