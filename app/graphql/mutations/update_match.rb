# frozen_string_literal: true

module Mutations
  class UpdateMatch < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :home_team_id, ID, required: false
    argument :away_team_id, ID, required: false
    argument :league_id, ID, required: false
    argument :match_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :score_home, Integer, required: false
    argument :score_away, Integer, required: false

    field :match, Types::MatchType, null: true
    field :errors, [String], null: false

    def resolve(id:, home_team_id: nil, away_team_id: nil, league_id: nil, match_date: nil, score_home: nil, score_away: nil)
      match = Match.find_by(id: id)
      return { match: nil, errors: ['Match not found'] } unless match

      if match.update(
        home_team_id: home_team_id,
        away_team_id: away_team_id,
        league_id: league_id,
        match_date: match_date,
        score_home: score_home,
        score_away: score_away
      )
        { match: match, errors: [] }
      else
        { match: nil, errors: match.errors.full_messages }
      end
    end
  end
end