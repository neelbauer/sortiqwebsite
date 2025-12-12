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

ActiveRecord::Schema[8.0].define(version: 2025_12_07_062653) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "grade"
    t.string "source"
    t.string "first_name"
    t.string "last_name"
    t.string "linkedin"
    t.string "email"
    t.string "phone"
    t.string "github"
    t.string "blog"
    t.text "fun"
    t.text "tech_stack"
    t.text "resume_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.text "notes"
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.string "url"
    t.string "phone_number"
    t.text "description"
    t.integer "headcount"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.boolean "is_client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "priority"
    t.text "notes"
    t.text "investors_memo"
    t.string "jobs_url"
  end

  create_table "company_candidates", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "candidate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_company_candidates_on_candidate_id"
    t.index ["company_id"], name: "index_company_candidates_on_company_id"
  end

  create_table "company_jobs", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_jobs_on_company_id"
    t.index ["job_id"], name: "index_company_jobs_on_job_id"
  end

  create_table "hiring_team_members", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name"
    t.string "title"
    t.string "phone_number"
    t.string "email"
    t.string "linkedin_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_hiring_team_members_on_company_id"
  end

  create_table "job_candidates", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "candidate_id", null: false
    t.string "stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_job_candidates_on_candidate_id"
    t.index ["job_id"], name: "index_job_candidates_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_url"
    t.string "hiring_manager"
    t.text "tech_stack"
    t.integer "salary_range_low"
    t.integer "salary_range_high"
    t.string "concise_description"
    t.text "description"
    t.date "date_opened"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_title"
    t.text "recruiting_notes"
    t.text "notes"
    t.string "site"
    t.string "commute"
  end

  create_table "resumes", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.string "filename"
    t.string "content_type"
    t.binary "file_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_resumes_on_candidate_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "company"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "company_candidates", "candidates"
  add_foreign_key "company_candidates", "companies"
  add_foreign_key "company_jobs", "companies"
  add_foreign_key "company_jobs", "jobs"
  add_foreign_key "hiring_team_members", "companies"
  add_foreign_key "job_candidates", "candidates"
  add_foreign_key "job_candidates", "jobs"
  add_foreign_key "resumes", "candidates"
end
