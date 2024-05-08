class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :run_time

      t.timestamps
    end
  end
end
