class Api::V1::LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :update, :destroy]

  # GET /leagues (with pagination)
  def index
    page = params[:page] || 1
    cache_key = "leagues_page_#{page}"
    
    # Try to fetch the data from Redis cache
    leagues = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      League.select(:id, :name, :country, :season, :founded, :division, :created_at, :updated_at)
            .page(page)
            .per(20)
            .to_a
    end

    total_pages = League.page(page).total_pages
    total_count = League.count

    # Render the response with pagination metadata
    render json: {
      data: leagues,
      pagination: {
        current_page: page.to_i,
        total_pages: total_pages,
        total_count: total_count
      }
    }
  end

  # GET /leagues/:id
  def show
    render json: @league
  end

  # POST /leagues
  def create
    league = League.new(league_params)

    if league.save
      render json: league, status: :created
    else
      render json: { errors: league.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /leagues/:id
  def update
    if @league.update(league_params)
      render json: @league
    else
      render json: { errors: @league.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /leagues/:id
  def destroy
    if @league.destroy
      render json: { message: "League successfully deleted" }, status: :ok
    else
      render json: { errors: @league.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_league
    @league = League.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["League not found"] }, status: :not_found
  end

  def league_params
    # Adjusted to match the columns in the leagues schema
    params.require(:league).permit(:name, :country, :season, :founded, :division)
  end
end
