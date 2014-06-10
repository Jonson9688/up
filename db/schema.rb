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

ActiveRecord::Schema.define(version: 20140610180625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_sessions", force: true do |t|
    t.integer  "owner_id"
    t.datetime "start_time"
    t.string   "location"
    t.string   "sport"
    t.datetime "request_time"
    t.string   "is_cancelled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_sessions_people", id: false, force: true do |t|
    t.integer "person_id",       null: false
    t.integer "game_session_id", null: false
  end

  create_table "people", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_phone_numbers", force: true do |t|
    t.integer  "person_id"
    t.string   "phone_number"
    t.string   "phone_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
