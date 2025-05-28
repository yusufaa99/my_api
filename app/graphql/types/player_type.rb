# frozen_string_literal: true

module Types
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :position, String, null: true
    field :team_id, Integer, null: true, description: "The ID of the team the player belongs to."
    field :age, Integer, null: true
    field :nationality, String, null: true
    field :height, Float, null: true
    field :weight, Float, null: true
    field :birth_date, GraphQL::Types::ISO8601DateTime, null: true
    field :goals, Integer, null: true
    field :matches_played, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
