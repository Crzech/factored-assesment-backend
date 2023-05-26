class PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /people
  def index
    @people = Person.all

    render json: @people
  end

  # GET /people/1
  def show
    render json: @person, include: :films
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    @film_ids = params[:film_ids]

    if !@film_ids || !@film_ids.is_a?(Array) || @film_ids.empty?
      return(
        render json: {
                 film_ids: ["shouldn't be empty and should be an array"],
               },
               status: :unprocessable_entity
      )
    end
    if @person.save
      ActiveRecord::Base.transaction do
        @film_ids.each do |film_id|
          film = nil
          begin
            film = Film.find(film_id)
          rescue ActiveRecord::RecordNotFound => e
            return(
              render json: {
                       film_ids: ["didn't find film #{film_id}"],
                     },
                     status: :unprocessable_entity
            )
          end
          new_film_people = FilmPerson.new(person: @person, film: film)
          unless new_film_people.save!
            return(
              render json: new_film_people.errors, status: :unprocessable_entity
            )
          end
        end
      end
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1
  def update
    @film_ids = params[:film_ids]
    if @film_ids && (!@film_ids.is_a?(Array) || @film_ids.empty?)
      return(
        render json: {
                 film_ids: ["shouldn't be empty and should be an array"],
               },
               status: :unprocessable_entity
      )
    end
    if @person.update(person_params)
      if @film_ids
        ActiveRecord::Base.transaction do
          FilmPerson.destroy_by(person_id: @person.id)
          @film_ids.each do |film_id|
            film = nil
            begin
              film = Film.find(film_id)
            rescue ActiveRecord::RecordNotFound => e
              return(
                render json: {
                         film_ids: ["didn't find film #{film_id}"],
                       },
                       status: :unprocessable_entity
              )
            end
            new_film_people = FilmPerson.new(person: @person, film: film)
            unless new_film_people.save!
              return(
                render json: new_film_people.errors,
                       status: :unprocessable_entity
              )
            end
          end
        end
      end
      render json: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(
      :name,
      :birth_year,
      :eye_color,
      :gender,
      :hair_color,
      :height,
      :mass,
      :skin_color,
      :planet_id,
    )
  end
end
