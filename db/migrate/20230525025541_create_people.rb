class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :birth_year
      t.string :eye_color
      t.string :gender
      t.string :hair_color
      t.string :height
      t.string :mass
      t.string :skin_color
      t.references :planet, foreign_key: { to_table: :planets, on_delete: :cascade }
      t.datetime :created, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :edited, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
