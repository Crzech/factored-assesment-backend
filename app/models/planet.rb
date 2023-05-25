class Planet < ApplicationRecord
  has_many :persons, dependent: :delete_all
  validates :name,
            :diameter,
            :rotation_period,
            :orbital_period,
            :gravity,
            :population,
            :climate,
            :terrain,
            :surface_water,
            presence: true
  validates :name,
            :diameter,
            :rotation_period,
            :orbital_period,
            :gravity,
            :population,
            :climate,
            :terrain,
            :surface_water,
            length: {
              maximum: 255,
              message: 'Length should be less than 255 characters'
            }
end
