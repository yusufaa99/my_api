# frozen_string_literal: true

module Types
  class TeamType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :stadium, String, null: true
    field :city, String, null: true
    field :founded, Integer, null: true # Updated to match the migration field name
    field :league_id, Integer, null: true, description: "The ID of the league the team belongs to."
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
