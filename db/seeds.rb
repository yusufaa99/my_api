require 'csv'
require 'faker'

# Define paths for CSV files
leagues_csv = Rails.root.join("db", "dataset", "leagues.csv")
teams_csv = Rails.root.join("db", "dataset", "teams.csv")
players_csv = Rails.root.join("db", "dataset", "players.csv")
matches_csv = Rails.root.join("db", "dataset", "matches.csv")

ActiveRecord::Base.transaction do
  # Seed Leagues
  puts "Seeding Leagues..."
  if File.exist?(leagues_csv)
    CSV.foreach(leagues_csv, headers: true) do |row|
      League.create!(
        name: row["name"],
        country: row["country"],
        season: row["season"],
        founded: row["founded"].to_i,
        division: row["division"]
      )
    end
  else
    100.times do |i|
      start_year = rand(2022..2025)
      League.create!(
        name: "League #{i + 1}",
        country: Faker::Address.country,
        season: "#{start_year}/#{start_year + 1}",
        founded: rand(1880..2025),
        division: ["Premier League", "Championship", "League One", "League Two"].sample
      )
    end
  end
  puts "✅ Leagues seeded successfully."

  # Seed Teams
  puts "Seeding Teams..."
  if File.exist?(teams_csv)
    CSV.foreach(teams_csv, headers: true) do |row|
      league = League.find_by(name: row["league_name"])
      if league.nil?
        puts "⚠️ Warning: League '#{row["league_name"]}' not found for team '#{row["name"]}'. Skipping..."
        next
      end

      Team.create!(
        name: row["name"],
        stadium: row["stadium"],
        city: row["city"],
        founded: row["founded"].to_i,
        league_id: league.id
      )
    end
  else
    100.times do
      league = League.order("RANDOM()").first
      Team.create!(
        name: Faker::Sports::Football.team,
        stadium: Faker::Address.community,
        city: Faker::Address.city,
        founded: rand(1880..2023),
        league_id: league.id
      )
    end    
  end
  puts "✅ Teams seeded successfully."

  # Seed Players
  puts "Seeding Players..."
  if File.exist?(players_csv)
    CSV.foreach(players_csv, headers: true) do |row|
      team = Team.find_by(name: row["team_name"])
      if team.nil?
        puts "⚠️ Warning: Team '#{row["team_name"]}' not found for player '#{row["name"]}'. Skipping..."
        next
      end

      Player.create!(
        name: row["name"],
        position: row["position"],
        age: row["age"].to_i,
        nationality: row["nationality"],
        height: row["height"].to_f,
        weight: row["weight"].to_f,
        birth_date: row["birth_date"].present? ? row["birth_date"].to_datetime : nil,
        goals: row["goals"].to_i,
        matches_played: row["matches_played"].to_i,
        team_id: team.id
      )
    end
  else
    1000.times do
      team = Team.order("RANDOM()").first
      Player.create!(
        name: Faker::Sports::Football.player,
        position: ["Striker", "Winger", "Central Midfielder", "Defensive Midfielder", "Center Back", "Full Back", "Goalkeeper"].sample,
        age: rand(18..40),
        nationality: Faker::Address.country,
        height: rand(1.6..2.1).round(2),
        weight: rand(60..100),
        birth_date: Faker::Date.birthday(min_age: 18, max_age: 40),
        goals: rand(0..300),
        matches_played: rand(0..800),
        team_id: team.id
      )
    end
  end
  puts "✅ Players seeded successfully."

  # Seed Matches
  puts "Seeding Matches..."
  if File.exist?(matches_csv)
    CSV.foreach(matches_csv, headers: true) do |row|
      home_team = Team.find_by(name: row["home_team"])
      away_team = Team.find_by(name: row["away_team"])
      league = League.find_by(name: row["league_name"])

      if home_team.nil? || away_team.nil? || league.nil?
        puts "⚠️ Warning: Missing team or league for match '#{row["home_team"]} vs #{row["away_team"]}'. Skipping..."
        next
      end

      Match.create!(
        home_team_id: home_team.id,
        away_team_id: away_team.id,
        score_home: row["score_home"].to_i,
        score_away: row["score_away"].to_i,
        match_date: row["match_date"].to_datetime,
        league_id: league.id
      )
    end
  else
    500.times do
      home_team = Team.order("RANDOM()").first
      away_team = Team.where.not(id: home_team.id).order("RANDOM()").first
      Match.create!(
        home_team_id: home_team.id,
        away_team_id: away_team.id,
        score_home: rand(0..5),
        score_away: rand(0..5),
        match_date: Faker::Date.between(from: '2022-01-01', to: Date.today),
        league_id: home_team.league_id
      )
    end
  end
  puts "✅ Matches seeded successfully."

  # Seed OAuth Applications
  if Doorkeeper::Application.count.zero?
    Doorkeeper::Application.create!(name: "React", redirect_uri: "", scopes: "")
    Doorkeeper::Application.create!(name: "Test client", redirect_uri: "", scopes: "")
    Doorkeeper::Application.create!(name: "Web client", redirect_uri: "", scopes: "")
  end

  # Seed Admin User
  User.first_or_create!(
    email: "mattemmsmartprince@gmail.com",
    password: "letmein123",
    password_confirmation: "letmein123",
    role: User.roles[:admin]
  )

  puts "✅ Seeding completed successfully!"
end
