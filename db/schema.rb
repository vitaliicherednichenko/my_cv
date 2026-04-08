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

ActiveRecord::Schema[7.1].define(version: 2026_04_08_210627) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "certificates", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.date "issue_date"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_certificates_on_profile_id"
  end

  create_table "educations", force: :cascade do |t|
    t.string "institution"
    t.string "degree"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_educations_on_profile_id"
  end

  create_table "experience_items", force: :cascade do |t|
    t.bigint "experience_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_experience_items_on_experience_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "company_name"
    t.string "position"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_experiences_on_profile_id"
  end

  create_table "header_styles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "bg_color"
    t.string "text_color"
    t.string "font"
    t.integer "font_size"
    t.boolean "bold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_header_styles_on_profile_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "level"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_languages_on_profile_id"
  end

  create_table "main_styles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "bg_color"
    t.string "text_color"
    t.string "font"
    t.integer "font_size"
    t.boolean "bold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_main_styles_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name", default: "Unknown", null: false
    t.string "title", default: "Unknown", null: false
    t.string "phone"
    t.string "email"
    t.string "location"
    t.text "summary"
    t.string "github_url"
    t.string "linkedin_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "github_url"
    t.string "live_url"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_projects_on_profile_id"
  end

  create_table "sidebar_styles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "bg_color"
    t.string "text_color"
    t.string "font"
    t.integer "font_size"
    t.boolean "bold"
    t.integer "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_sidebar_styles_on_profile_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "category"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_skills_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "certificates", "profiles"
  add_foreign_key "educations", "profiles"
  add_foreign_key "experience_items", "experiences"
  add_foreign_key "experiences", "profiles"
  add_foreign_key "header_styles", "profiles"
  add_foreign_key "languages", "profiles"
  add_foreign_key "main_styles", "profiles"
  add_foreign_key "projects", "profiles"
  add_foreign_key "sidebar_styles", "profiles"
  add_foreign_key "skills", "profiles"
end
