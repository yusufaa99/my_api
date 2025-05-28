# frozen_string_literal: true

module Types
  class MatchType < Types::BaseObject
    field :id, ID, null: false
    field :home_team_id, Integer, null: false
    field :away_team_id, Integer, null: false
    field :score_home, Integer, null: true
    field :score_away, Integer, null: true
    field :match_date, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end