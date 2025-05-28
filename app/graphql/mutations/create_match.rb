# frozen_string_literal: true

module Mutations
  class CreateMatch < Mutations::BaseMutation
    argument :home_team_id, ID, required: true
    argument :away_team_id, ID, required: true
    argument :league_id, ID, required: true
    argument :match_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :score_home, Integer, required: true
    argument :score_away, Integer, required: true

    field :match, Types::MatchType, null: true
    field :errors, [String], null: false

    def resolve(home_team_id:, away_team_id:, league_id:, match_date:, score_home:, score_away:)
      home_team = Team.find_by(id: home_team_id)
      away_team = Team.find_by(id: away_team_id)
      league = League.find_by(id: league_id)

      return { match: nil, errors: ["Teams or league not found"] } unless home_team && away_team && league

      match = Match.new(
        home_team_id: home_team.id,
        away_team_id: away_team.id,
        league_id: league.id,
        match_date: match_date,
        score_home: score_home,
        score_away: score_away
      )

      if match.save
        { match: match, errors: [] }
      else
        { match: nil, errors: match.errors.full_messages }
      end
    end
  end
end