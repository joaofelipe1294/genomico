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

ActiveRecord::Schema.define(version: 2019_07_13_184422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_status_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "desease_stage_id"
    t.string "cid_code"
    t.string "lis_code"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.bigint "patient_id"
    t.bigint "attendance_status_kind_id"
    t.string "doctor_name"
    t.string "doctor_crm"
    t.string "observations"
    t.bigint "health_ensurance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "report_file_name"
    t.string "report_content_type"
    t.integer "report_file_size"
    t.datetime "report_updated_at"
    t.index ["attendance_status_kind_id"], name: "index_attendances_on_attendance_status_kind_id"
    t.index ["desease_stage_id"], name: "index_attendances_on_desease_stage_id"
    t.index ["health_ensurance_id"], name: "index_attendances_on_health_ensurance_id"
    t.index ["patient_id"], name: "index_attendances_on_patient_id"
  end

  create_table "attendances_work_maps", force: :cascade do |t|
    t.bigint "attendance_id"
    t.bigint "work_map_id"
    t.index ["attendance_id"], name: "index_attendances_work_maps_on_attendance_id"
    t.index ["work_map_id"], name: "index_attendances_work_maps_on_work_map_id"
  end

  create_table "backups", force: :cascade do |t|
    t.datetime "generated_at"
    t.boolean "status"
    t.string "dump_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "desease_stages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exam_status_changes", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "exam_status_kind_id"
    t.datetime "change_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_status_changes_on_exam_id"
    t.index ["exam_status_kind_id"], name: "index_exam_status_changes_on_exam_status_kind_id"
  end

  create_table "exam_status_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exams", force: :cascade do |t|
    t.bigint "offered_exam_id"
    t.date "start_date"
    t.date "finish_date"
    t.bigint "exam_status_kind_id"
    t.bigint "attendance_id"
    t.bigint "sample_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subsample_id"
    t.boolean "uses_subsample"
    t.index ["attendance_id"], name: "index_exams_on_attendance_id"
    t.index ["exam_status_kind_id"], name: "index_exams_on_exam_status_kind_id"
    t.index ["offered_exam_id"], name: "index_exams_on_offered_exam_id"
    t.index ["sample_id"], name: "index_exams_on_sample_id"
    t.index ["subsample_id"], name: "index_exams_on_subsample_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_ensurances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nanodrop_reports", force: :cascade do |t|
    t.float "concentration"
    t.float "rate_260_280"
    t.float "rate_260_230"
    t.bigint "subsample_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subsample_id"], name: "index_nanodrop_reports_on_subsample_id"
  end

  create_table "offered_exams", force: :cascade do |t|
    t.string "name"
    t.bigint "field_id"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_offered_exams_on_field_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.date "birth_date"
    t.string "mother_name"
    t.string "medical_record"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hospital_id"
    t.index ["hospital_id"], name: "index_patients_on_hospital_id"
  end

  create_table "qubit_reports", force: :cascade do |t|
    t.float "concentration"
    t.bigint "subsample_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subsample_id"], name: "index_qubit_reports_on_subsample_id"
  end

  create_table "sample_kinds", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.integer "refference_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "samples", force: :cascade do |t|
    t.bigint "sample_kind_id"
    t.boolean "has_subsample"
    t.date "entry_date"
    t.date "collection_date"
    t.string "refference_label"
    t.integer "bottles_number"
    t.bigint "attendance_id"
    t.string "storage_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_id"], name: "index_samples_on_attendance_id"
    t.index ["sample_kind_id"], name: "index_samples_on_sample_kind_id"
  end

  create_table "samples_work_maps", force: :cascade do |t|
    t.bigint "sample_id"
    t.bigint "work_map_id"
    t.index ["sample_id"], name: "index_samples_work_maps_on_sample_id"
    t.index ["work_map_id"], name: "index_samples_work_maps_on_work_map_id"
  end

  create_table "subsample_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "acronym"
    t.integer "refference_index"
  end

  create_table "subsamples", force: :cascade do |t|
    t.string "storage_location"
    t.string "refference_label"
    t.bigint "subsample_kind_id"
    t.bigint "sample_id"
    t.datetime "collection_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "attendance_id"
    t.index ["attendance_id"], name: "index_subsamples_on_attendance_id"
    t.index ["sample_id"], name: "index_subsamples_on_sample_id"
    t.index ["subsample_kind_id"], name: "index_subsamples_on_subsample_kind_id"
  end

  create_table "subsamples_work_maps", force: :cascade do |t|
    t.bigint "subsample_id"
    t.bigint "work_map_id"
    t.index ["subsample_id"], name: "index_subsamples_work_maps_on_subsample_id"
    t.index ["work_map_id"], name: "index_subsamples_work_maps_on_work_map_id"
  end

  create_table "user_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "password_digest"
    t.string "name"
    t.boolean "is_active"
    t.bigint "user_kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_kind_id"], name: "index_users_on_user_kind_id"
  end

  create_table "work_maps", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "map_file_name"
    t.string "map_content_type"
    t.integer "map_file_size"
    t.datetime "map_updated_at"
  end

  add_foreign_key "attendances", "attendance_status_kinds"
  add_foreign_key "attendances", "desease_stages"
  add_foreign_key "attendances", "health_ensurances"
  add_foreign_key "attendances", "patients"
  add_foreign_key "exam_status_changes", "exam_status_kinds"
  add_foreign_key "exam_status_changes", "exams"
  add_foreign_key "exams", "attendances"
  add_foreign_key "exams", "exam_status_kinds"
  add_foreign_key "exams", "offered_exams"
  add_foreign_key "exams", "samples"
  add_foreign_key "nanodrop_reports", "subsamples"
  add_foreign_key "offered_exams", "fields"
  add_foreign_key "patients", "hospitals"
  add_foreign_key "qubit_reports", "subsamples"
  add_foreign_key "samples", "attendances"
  add_foreign_key "samples", "sample_kinds"
  add_foreign_key "subsamples", "samples"
  add_foreign_key "subsamples", "subsample_kinds"
  add_foreign_key "users", "user_kinds"
end
