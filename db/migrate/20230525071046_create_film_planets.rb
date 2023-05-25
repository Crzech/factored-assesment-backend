class CreateFilmPlanets < ActiveRecord::Migration[7.0]
  def change
    create_table :film_planets do |t|
      t.references :film,
                   null: false,
                   foreign_key: {
                     to_table: :films,
                     on_delete: :cascade,
                   }
      t.references :planet,
                   null: false,
                   foreign_key: {
                     to_table: :planets,
                     on_delete: :cascade,
                   }
    end
  end
end
