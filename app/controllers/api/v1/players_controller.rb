# app\controllers\api\v1\players_controller.rb
class Api::V1::PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players (with pagination)
  def index
    page = params[:page] || 1
    cache_key = "players_page_#{page}"

    # Try to fetch the data from Redis cache
    players = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      Player.page(page).per(20).to_a
    end

    # Render the response with pagination metadata
    render json: {
      data: players,
      pagination: {
        current_page: page.to_i,
        total_pages: Player.page(page).total_pages,
        total_count: Player.page(page).total_count
      }
    }
  end

  # GET /players/:id
  def show
    render json: @player
  end

  # POST /players
  def create
    player = Player.new(player_params)

    if player.save
      render json: player, status: :created
    else
      render json: player.errors, status: :unprocessable_entity
    end
  end

  # PUT /players/:id
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/:id
  def destroy
    @player.destroy
  end

  private

  # Set the player for the actions that require it (show, update, destroy)
  def set_player
    @player = Player.find(params[:id])
  end

  # Strong parameters for player
  def player_params
    # Adjusted to match the schema: name, position, team_id, goals, matches_played, age, nationality, height, weight, and birth_date
    params.require(:player).permit(
      :name, 
      :position, 
      :team_id, 
      :goals, 
      :matches_played, 
      :age, 
      :nationality, 
      :height, 
      :weight, 
      :birth_date
    )
  end
end
