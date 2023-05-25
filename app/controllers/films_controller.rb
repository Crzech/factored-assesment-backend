class FilmsController < ApplicationController
  before_action :set_film, only: %i[show update destroy]

  # GET /films
  def index
    @films = Film.all

    render json: @films
  end

  # GET /films/1
  def show
    render json: @film, include: [:planets]
  end

  # POST /films
  def create
    @film = Film.new(film_params)
    @planet_ids = params[:planet_ids]

    if !@planet_ids || !@planet_ids.is_a?(Array) || @planet_ids.empty?
      return(
        render json: {
                 planet_ids: ["shouldn't be empty and should be an array"],
               },
               status: :unprocessable_entity
      )
    end

    if @film.save
      ActiveRecord::Base.transaction do
        @planet_ids.each do |planet_id|
          planet = nil
          begin
            planet = Planet.find(planet_id)
          rescue ActiveRecord::RecordNotFound => e
            return(
              render json: {
                       planet_ids: ["didn't find planet #{planet_id}"],
                     },
                     status: :unprocessable_entity
            )
          end
          new_film_planet = FilmPlanet.new(planet: planet, film: @film)
          unless new_film_planet.save!
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
      @planet_ids = params[:planet_ids]
      if @planet_ids
        if !@planet_ids.is_a?(Array) || @planet_ids.empty?
          return(
            render json: {
                     planet_ids: ["shouldn't be empty and should be an array"],
                   },
                   status: :unprocessable_entity
          )
        end
        ActiveRecord::Base.transaction do
          FilmPlanet.destroy_by(film_id: @film.id)
          @planet_ids.each do |planet_id|
            planet = nil
            begin
              planet = Planet.find(planet_id)
            rescue ActiveRecord::RecordNotFound => e
              return(
                render json: {
                         planet_ids: ["didn't find planet #{planet_id}"],
                       },
                       status: :unprocessable_entity
              )
            end
            new_film_planet = FilmPlanet.new(planet: planet, film: @film)
            unless new_film_planet.save!
              return(
                render json: new_film_planet.errors,
                       status: :unprocessable_entity
              )
            end
          end
        end
      end
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
      :release_date,
    )
  end
end
