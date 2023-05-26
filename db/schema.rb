# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_26_004956) do
  create_table "film_people", force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "person_id", null: false
    t.index ["film_id"], name: "index_film_people_on_film_id"
    t.index ["person_id"], name: "index_film_people_on_person_id"
  end

  create_table "film_planets", force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "planet_id", null: false
    t.index ["film_id"], name: "index_film_planets_on_film_id"
    t.index ["planet_id"], name: "index_film_planets_on_planet_id"
  end

  create_table "films", force: :cascade do |t|
    t.string "title"
    t.integer "episode_id"
    t.text "opening_crawl"
    t.string "director"
    t.string "producer"
    t.date "release_date"
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "edited", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "birth_year"
    t.string "eye_color"
    t.string "gender"
    t.string "hair_color"
    t.string "height"
    t.string "mass"
    t.string "skin_color"
    t.integer "planet_id"
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["planet_id"], name: "index_people_on_planet_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.string "diameter"
    t.string "rotation_period"
    t.string "orbital_period"
    t.string "gravity"
    t.string "population"
    t.string "climate"
    t.string "terrain"
    t.string "surface_water"
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "film_people", "films", on_delete: :cascade
  add_foreign_key "film_people", "people", on_delete: :cascade
  add_foreign_key "film_planets", "films", on_delete: :cascade
  add_foreign_key "film_planets", "planets", on_delete: :cascade
  add_foreign_key "people", "planets", on_delete: :cascade
end
