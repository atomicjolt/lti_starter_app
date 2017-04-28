class CreateLtiLaunches < ActiveRecord::Migration[5.0]
  def change
    create_table :lti_launches do |t|
      t.jsonb :config
      t.timestamps
    end
  end
end
