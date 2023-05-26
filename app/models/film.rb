class Film < ApplicationRecord
  has_many :film_planets, dependent: :destroy
  has_many :planets, through: :film_planets
  has_many :film_people, dependent: :destroy
  has_many :people, through: :film_people
  validates :title,
            :episode_id,
            :opening_crawl,
            :director,
            :producer,
            :release_date,
            presence: true
  validates :title,
            :director,
            :producer,
            length: {
              maximum: 255,
              message: "Length should be less than 255 characters",
            }
  validates :episode_id, numericality: { only_integer: true }
  validates_date :release_date, message: "should be a date"
end
