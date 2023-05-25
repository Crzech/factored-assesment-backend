class FilmsController < ApplicationController
  before_action :set_film, only: %i[show update destroy]

  # GET /films
  def index
    @films = Film.all

    render json: @films
  end

  # GET /films/1
  def show
    render json: @film
  end

  # POST /films
  def create
    @film = Film.new(film_params)

    if @film.save
      ActiveRecord::Base.transaction do
        params[:planet_ids].each do |planet_id|
          planet = Planet.find(planet_id)
          new_film_planet = FilmPlanet.new(planet: planet, film: @film)
          if !new_film_planet.save()
            return(
              render json: new_film_planet.errors, status: :unprocessable_entity
            )
          end
        end
      end
      render json: @film, status: :created, location: @film
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /films/1
  def update
    if @film.update(film_params)
      render json: @film
    else
      render json: @film.errors, status: :unprocessable_entity
    end
  end

  # DELETE /films/1
  def destroy
    @film.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_film
    @film = Film.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def film_params
    params.require(:film).permit(
      :title,
      :episode_id,
      :opening_crawl,
      :director,
      :producer,
      :release_date
    )
  end
end
