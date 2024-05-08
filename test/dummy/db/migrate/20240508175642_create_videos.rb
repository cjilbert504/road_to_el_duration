class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :name
      t.integer :length
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
