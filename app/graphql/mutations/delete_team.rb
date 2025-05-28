# frozen_string_literal: true

module Mutations
  class DeleteTeam < Mutations::BaseMutation
    argument :id, ID, required: true

    field :team, Types::TeamType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      team = Team.find_by(id: id)
      return { team: nil, errors: ['Team not found'] } unless team

      if team.destroy
        { team: team, errors: [] }
      else
        { team: nil, errors: team.errors.full_messages }
      end
    end
  end
end
