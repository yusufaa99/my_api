# frozen_string_literal: true

module Mutations
  class CreatePlayer < Mutations::BaseMutation
    argument :name, String, required: true
    argument :position, String, required: true
    argument :age, Integer, required: true
    argument :nationality, String, required: true
    argument :team_id, ID, required: true
    argument :height, Float, required: false
    argument :weight, Float, required: false
    argument :birth_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :goals, Integer, required: false
    argument :matches_played, Integer, required: false

    field :player, Types::PlayerType, null: true
    field :errors, [String], null: false

    def resolve(name:, position:, age:, nationality:, team_id:, height: nil, weight: nil, birth_date: nil, goals: 0, matches_played: 0)
      team = Team.find_by(id: team_id)
      return { player: nil, errors: ["Team not found"] } unless team

      player = Player.new(
        name: name,
        position: position,
        age: age,
        nationality: nationality,
        team_id: team.id,
        height: height,
        weight: weight,
        birth_date: birth_date,
        goals: goals,
        matches_played: matches_played
      )

      if player.save
        { player: player, errors: [] }
      else
        { player: nil, errors: player.errors.full_messages }
      end
    end
  end
end
