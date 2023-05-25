class PlanetsController < ApplicationController
  before_action :set_planet, only: %i[show update destroy]

  # GET /planets
  def index
    @planets = Planet.all

    render json: @planets
  end

  # GET /planets/1
  def show
    @planet = Planet.find(params[:id])
    render json: @planet
  end

  # POST /planets
  def create
    @planet = Planet.new(planet_params)

    if @planet.save
      render json: @planet, status: :created, location: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planets/1
  def update
    if @planet.update(planet_params)
      render json: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planets/1
  def destroy
    @planet.destroy
  end

  private

  def set_planet
    @planet = Planet.find(params[:id])
  end

  def planet_params
    params.require(:planet).permit(
      :id,
      :name,
      :diameter,
      :rotation_period,
      :orbital_period,
      :gravity,
      :population,
      :climate,
      :terrain,
      :surface_water,
    )
  end
end
