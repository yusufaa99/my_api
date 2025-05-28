# frozen_string_literal: true

module Mutations
  class CreateTeam < Mutations::BaseMutation
    argument :name, String, required: true
    argument :city, String, required: true
    argument :stadium, String, required: true
    argument :founded_in, Integer, required: true
    argument :league_id, ID, required: true

    field :team, Types::TeamType, null: true
    field :errors, [String], null: false

    def resolve(name:, city:, stadium:, founded_in:, league_id:)
      league = League.find_by(id: league_id)
      return { team: nil, errors: ["League not found"] } unless league

      team = Team.new(name: name, city: city, stadium: stadium, founded: founded_in, league_id: league.id)
      if team.save
        { team: team, errors: [] }
      else
        { team: nil, errors: team.errors.full_messages }
      end
    end
  end
end
