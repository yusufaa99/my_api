# app\controllers\api\v1\teams_controller.rb
class Api::V1::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]

  # GET /teams (with pagination)
  def index
    page = params[:page] || 1
    cache_key = "teams_page_#{page}"

    # Try to fetch the data from Redis cache
    teams = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      Team.page(page).per(20).to_a
    end

    # Render the response with pagination metadata
    render json: {
      data: teams,
      pagination: {
        current_page: page.to_i,
        total_pages: Team.page(page).total_pages,
        total_count: Team.page(page).total_count
      }
    }
  end

  # GET /teams/:id
  def show
    render json: @team
  end

  # POST /teams
  def create
    team = Team.new(team_params)

    if team.save
      render json: team, status: :created
    else
      render json: team.errors, status: :unprocessable_entity
    end
  end

  # PUT /teams/:id
  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/:id
  def destroy
    @team.destroy
  end

  private

  # Set the team for the actions that require it (show, update, destroy)
  def set_team
    @team = Team.find(params[:id])
  end

  # Strong parameters for team
  def team_params
    # Adjusted to match the schema: name,  city,  stadium, founded_in and league_id
    params.require(:team).permit(
      :name, 
      :stadium,
      :city,
      :founded_in, 
      :league_id
    )
  end
end