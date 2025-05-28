# frozen_string_literal: true

module Mutations
  class UpdateTeam < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :stadium, String, required: false
    argument :city, String, required: false
    argument :country, String, required: false

    field :team, Types::TeamType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, stadium: nil, city: nil, country: nil)
      team = Team.find_by(id: id)
      return { team: nil, errors: ['Team not found'] } unless team

      if team.update(name: name, stadium: stadium, city: city, country: country)
        { team: team, errors: [] }
      else
        { team: nil, errors: team.errors.full_messages }
      end
    end
  end
end
