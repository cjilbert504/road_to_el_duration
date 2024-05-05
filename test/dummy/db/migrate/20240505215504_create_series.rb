class CreateSeries < ActiveRecord::Migration[7.1]
  def change
    create_table :series do |t|
      t.string :name
      t.integer :duration

      t.timestamps
    end
  end
end
