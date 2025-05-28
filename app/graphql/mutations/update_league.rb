# frozen_string_literal: true

module Mutations
  class UpdateLeague < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :country, String, required: false
    argument :season, String, required: false
    argument :founded, Integer, required: false
    argument :division, String, required: false

    field :league, Types::LeagueType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, country: nil, season: nil, founded: nil, division: nil)
      league = League.find_by(id: id)
      return { league: nil, errors: ['League not found'] } unless league

      if league.update(name: name, country: country, season: season, founded: founded, division: division)
        { league: league, errors: [] }
      else
        { league: nil, errors: league.errors.full_messages }
      end
    end
  end
end
