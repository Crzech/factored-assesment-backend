class FilmPlanet < ApplicationRecord
  belongs_to :film
  belongs_to :planet
  validates :planet, :film, presence: true
end
