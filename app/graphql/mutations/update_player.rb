# frozen_string_literal: true

module Mutations
  class UpdatePlayer < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :team_id, ID, required: false
    argument :position, String, required: false
    argument :height, Float, required: false
    argument :weight, Float, required: false
    argument :birth_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :age, Integer, required: false
    argument :nationality, String, required: false
    argument :goals, Integer, required: false
    argument :matches_played, Integer, required: false

    field :player, Types::PlayerType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, team_id: nil, position: nil, height: nil, weight: nil, birth_date: nil, age: nil, nationality: nil, goals: nil, matches_played: nil)
      player = Player.find_by(id: id)
      return { player: nil, errors: ['Player not found'] } unless player

      if player.update(name: name, team_id: team_id, position: position, height: height, weight: weight, birth_date: birth_date, age: age, nationality: nationality, goals: goals, matches_played: matches_played)
        { player: player, errors: [] }
      else
        { player: nil, errors: player.errors.full_messages }
      end
    end
  end
end
