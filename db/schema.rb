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

ActiveRecord::Schema.define(version: 20190609164618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_status_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_ensurances", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offered_exams", force: :cascade do |t|
    t.string   "name"
    t.integer  "field_id"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "offered_exams", ["field_id"], name: "index_offered_exams_on_field_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.string   "name"
    t.date     "birth_date"
    t.string   "mother_name"
    t.string   "medical_record"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "user_kinds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "password_digest"
    t.string   "name"
    t.boolean  "is_active"
    t.integer  "user_kind_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["user_kind_id"], name: "index_users_on_user_kind_id", using: :btree

  add_foreign_key "offered_exams", "fields"
  add_foreign_key "users", "user_kinds"
end
