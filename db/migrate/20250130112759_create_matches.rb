class CreateMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :matches do |t|
      t.bigint :home_team_id, null: false
      t.bigint :away_team_id, null: false
      t.integer :score_home
      t.integer :score_away
      t.datetime :match_date
      t.bigint :league_id, null: false
      t.timestamps
    end
    add_index :matches, :home_team_id
    add_index :matches, :away_team_id
    add_index :matches, :league_id

    add_foreign_key :matches, :teams, column: :home_team_id
    add_foreign_key :matches, :teams, column: :away_team_id
    add_foreign_key :matches, :leagues
  end
end
