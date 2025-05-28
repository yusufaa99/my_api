# frozen_string_literal: true

module Mutations
  class DeleteLeague < Mutations::BaseMutation
    argument :id, ID, required: true

    field :league, Types::LeagueType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      league = League.find_by(id: id)
      return { league: nil, errors: ['League not found'] } unless league

      if league.destroy
        { league: league, errors: [] }
      else
        { league: nil, errors: league.errors.full_messages }
      end
    end
  end
end
