# app\controllers\api\v1\matches_controller.rb
class Api::V1::MatchesController < ApplicationController
  before_action :set_match, only: [:show, :update, :destroy]

  # GET /matches (with pagination)
  def index
    page = params[:page] || 1
    cache_key = "matches_page_#{page}"

    # Try to fetch the data from Redis cache
    matches = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      Match.page(page).per(20).to_a
    end

    # Render the response with pagination metadata
    render json: {
      data: matches,
      pagination: {
        current_page: page.to_i,
        total_pages: Match.page(page).total_pages,
        total_count: Match.page(page).total_count
      }
    }
  end

  # GET /matches/:id
  def show
    render json: @match
  end

  # POST /matches
  def create
    match = Match.new(match_params)

    if match.save
      render json: match, status: :created
    else
      render json: match.errors, status: :unprocessable_entity
    end
  end

  # PUT /matches/:id
  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/:id
  def destroy
    @match.destroy
  end

  private

  # Set the match for the actions that require it (show, update, destroy)
  def set_match
    @match = Match.find(params[:id])
  end

  # Strong parameters for match
  def match_params
    params.require(:match).permit(:home_team_id, :away_team_id, :score_home, :score_away, :match_date, :league_id)
  end
end
