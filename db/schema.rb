# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_30_152718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "encounters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "party_id"
    t.index ["party_id"], name: "index_encounters_on_party_id"
  end

  create_table "fates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "group_size"
    t.uuid "encounter_id", null: false
    t.uuid "monster_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["encounter_id", "monster_id", "group_size"], name: "index_fates_on_encounter_id_and_monster_id_and_group_size", unique: true
    t.index ["encounter_id"], name: "index_fates_on_encounter_id"
    t.index ["monster_id"], name: "index_fates_on_monster_id"
  end

  create_table "monsters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "species"
    t.string "armor_class"
    t.string "hit_points"
    t.string "challenge_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.uuid "party_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["party_id"], name: "index_players_on_party_id"
  end

  add_foreign_key "encounters", "parties"
  add_foreign_key "fates", "encounters"
  add_foreign_key "fates", "monsters"
  add_foreign_key "players", "parties"
end
