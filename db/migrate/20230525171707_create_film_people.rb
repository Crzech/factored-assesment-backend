class CreateFilmPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :film_people do |t|
      t.references :film,
                   null: false,
                   foreign_key: {
                     to_table: :films,
                     on_delete: :cascade,
                   }
      t.references :person,
                   null: false,
                   foreign_key: {
                     to_table: :people,
                     on_delete: :cascade,
                   }
    end
  end
end
