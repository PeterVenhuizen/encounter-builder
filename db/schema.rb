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

ActiveRecord::Schema.define(version: 2022_02_17_080232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "encounters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "party_id"
    t.json "stats", default: {}
    t.index ["party_id"], name: "index_encounters_on_party_id"
  end

  create_table "fates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "group_size", default: 1
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
    t.integer "hit_points"
    t.string "challenge_rating", default: "0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "alignment"
    t.string "hit_dice"
    t.hstore "ability_scores", default: {"wisdom"=>"10", "charisma"=>"10", "strength"=>"10", "dexterity"=>"10", "constitution"=>"10", "intelligence"=>"10"}
    t.integer "xp"
    t.integer "proficiency_bonus", default: 2
    t.hstore "speed", default: {"fly"=>"0", "swim"=>"0", "walk"=>"0", "climb"=>"0", "burrow"=>"0"}
    t.string "languages"
  end

  create_table "parties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "level", default: 1
    t.uuid "party_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["party_id"], name: "index_players_on_party_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "encounters", "parties"
  add_foreign_key "fates", "encounters"
  add_foreign_key "fates", "monsters"
  add_foreign_key "players", "parties"
end
