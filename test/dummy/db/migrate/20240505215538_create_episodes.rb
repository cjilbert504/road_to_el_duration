class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :duration
      t.belongs_to :series, foreign_key: true

      t.timestamps
    end
  end
end
