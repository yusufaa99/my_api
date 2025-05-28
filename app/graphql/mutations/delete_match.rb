# frozen_string_literal: true

module Mutations
  class DeleteMatch < Mutations::BaseMutation
    argument :id, ID, required: true

    field :match, Types::MatchType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      match = Match.find_by(id: id)
      return { match: nil, errors: ['Match not found'] } unless match

      if match.destroy
        { match: match, errors: [] }
      else
        { match: nil, errors: match.errors.full_messages }
      end
    end
  end
end
