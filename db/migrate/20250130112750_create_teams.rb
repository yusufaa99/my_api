class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :stadium
      t.string :city
      t.integer :founded # This matches the existing migration field name
      t.bigint :league_id, null: false
      t.timestamps
    end
    add_index :teams, :league_id
    add_foreign_key :teams, :leagues
  end
end
