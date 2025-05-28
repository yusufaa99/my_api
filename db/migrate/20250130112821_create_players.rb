class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name
      t.bigint :team_id, null: false
      t.string :position
      t.integer :age
      t.string :nationality
      t.float :height
      t.float :weight
      t.datetime :birth_date
      t.integer :goals
      t.integer :matches_played
      t.timestamps
    end
    add_index :players, :team_id
    add_foreign_key :players, :teams
  end
end
