# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141105123047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_events", force: true do |t|
    t.integer  "character_id"
    t.integer  "computed_event_id"
    t.integer  "status",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note",              default: ""
  end

  add_index "character_events", ["character_id"], name: "index_character_events_on_character_id", using: :btree
  add_index "character_events", ["computed_event_id"], name: "index_character_events_on_computed_event_id", using: :btree

  create_table "characters", force: true do |t|
    t.string   "name"
    t.integer  "klass"
    t.integer  "role"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "characters", ["team_id"], name: "index_characters_on_team_id", using: :btree
  add_index "characters", ["user_id"], name: "index_characters_on_user_id", using: :btree

  create_table "computed_events", force: true do |t|
    t.date     "date"
    t.string   "identifier"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "computed_events", ["event_id"], name: "index_computed_events_on_event_id", using: :btree
  add_index "computed_events", ["identifier"], name: "index_computed_events_on_identifier", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "event_type"
    t.integer  "weekday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true, using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "shorthand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "rank",                   default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "last_claim"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
