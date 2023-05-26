class Person < ApplicationRecord
  belongs_to :planet
  has_many :film_people, dependent: :destroy
  has_many :films, through: :film_people
  validates :name,
            :birth_year,
            :eye_color,
            :gender,
            :hair_color,
            :height,
            :mass,
            :skin_color,
            :planet,
            presence: true
  validates :name,
            :birth_year,
            :eye_color,
            :gender,
            :hair_color,
            :height,
            :mass,
            :skin_color,
            length: {
              maximum: 255,
              message: "Length should be less than 255 characters",
            }
end
