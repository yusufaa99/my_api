# frozen_string_literal: true

module Mutations
  class DeletePlayer < Mutations::BaseMutation
    argument :id, ID, required: true

    field :player, Types::PlayerType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      player = Player.find_by(id: id)
      return { player: nil, errors: ['Player not found'] } unless player

      if player.destroy
        { player: player, errors: [] }
      else
        { player: nil, errors: player.errors.full_messages }
      end
    end
  end
end
