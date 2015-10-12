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

ActiveRecord::Schema.define(version: 20151009084711) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255,             null: false
    t.integer  "delete_flag", limit: 4,   default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",           limit: 255,             null: false
    t.integer  "category_id",    limit: 4,               null: false
    t.integer  "abolished_flag", limit: 4,   default: 0, null: false
    t.integer  "delete_flag",    limit: 4,   default: 0, null: false
    t.integer  "company_sub_id", limit: 4,               null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "rosens", force: :cascade do |t|
    t.string   "name",           limit: 255,                                     null: false
    t.integer  "start_id",       limit: 4,                                       null: false
    t.integer  "end_id",         limit: 4,                                       null: false
    t.decimal  "kilo",                       precision: 9, scale: 1
    t.integer  "company_id",     limit: 4,                                       null: false
    t.integer  "abolished_flag", limit: 4,                           default: 0, null: false
    t.integer  "delete_flag",    limit: 4,                           default: 0, null: false
    t.integer  "rosen_sub_id",   limit: 4,                                       null: false
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "section_sub_id", limit: 4
    t.integer  "start_id",       limit: 4
    t.integer  "end_id",         limit: 4
    t.integer  "next_hop_id",    limit: 4
    t.integer  "rosen_id",       limit: 4
    t.decimal  "kilo",                     precision: 9, scale: 1,             null: false
    t.integer  "abolished_flag", limit: 4,                         default: 0, null: false
    t.integer  "delete_flag",    limit: 4,                         default: 0, null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",        limit: 255,             null: false
    t.integer  "delete_flag", limit: 4,   default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name",           limit: 255,             null: false
    t.string   "name_ruby",      limit: 255,             null: false
    t.integer  "company_id",     limit: 4
    t.integer  "state_id",       limit: 4
    t.integer  "abolished_flag", limit: 4,   default: 0, null: false
    t.integer  "delete_flag",    limit: 4,   default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "user_section_statuses", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,             null: false
    t.integer  "section_id",  limit: 4,             null: false
    t.date     "ride_day"
    t.integer  "ride_chk",    limit: 4, default: 0
    t.integer  "delete_flag", limit: 4, default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "user_station_statuses", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,             null: false
    t.integer  "station_id",  limit: 4,             null: false
    t.date     "visit_day"
    t.integer  "visit_chk",   limit: 4, default: 0
    t.integer  "delete_flag", limit: 4, default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.integer  "delete_flag",     limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "remember_token",  limit: 255
  end

end
