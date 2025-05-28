# frozen_string_literal: true

module Types
  class LeagueType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :country, String, null: true
    field :season, String, null: true
    field :founded, Integer, null: true
    field :division, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
