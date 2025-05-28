# frozen_string_literal: true

module Mutations
  class CreateLeague < Mutations::BaseMutation
    argument :name, String, required: true
    argument :country, String, required: true
    argument :season, String, required: false
    argument :founded, Integer, required: false
    argument :division, String, required: false

    field :league, Types::LeagueType, null: true
    field :errors, [String], null: false

    def resolve(name:, country:, season: nil, founded: nil, division: nil)
      league = League.new(name: name, country: country, season: season, founded: founded, division: division)
      if league.save
        { league: league, errors: [] }
      else
        { league: nil, errors: league.errors.full_messages }
      end
    end
  end
end
