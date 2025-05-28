class CreateLeagues < ActiveRecord::Migration[7.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :country
      t.string :season
      t.integer :founded
      t.string :division
      t.timestamps
    end
  end
end
