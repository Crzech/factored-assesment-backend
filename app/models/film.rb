class Film < ApplicationRecord
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
