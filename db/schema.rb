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

ActiveRecord::Schema.define(version: 20181216211203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_messages", force: :cascade do |t|
    t.string   "from_name"
    t.string   "from_email"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.string   "alert_title"
    t.text     "alert_body"
    t.string   "alert_type"
    t.integer  "alert_to"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "scheduled_alert"
  end

  create_table "bio_answers", force: :cascade do |t|
    t.integer  "bio_question_id"
    t.text     "answer_text"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "bio_questions", force: :cascade do |t|
    t.text     "question_text"
    t.integer  "question_order_by"
    t.boolean  "active"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "bios", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "profile_text"
    t.string   "style_text"
    t.string   "expertise"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "profile_image"
    t.boolean  "profile_active"
  end

  create_table "book_resources", force: :cascade do |t|
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "path"
    t.string   "file_name"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "logo_path"
    t.string   "name"
    t.text     "description"
    t.string   "logo_filename"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "content_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "invited_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "confirmed"
  end

  create_table "group_messages", force: :cascade do |t|
    t.integer  "from"
    t.integer  "group_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "creator"
    t.string   "privacy"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: :cascade do |t|
    t.text     "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mentorships", force: :cascade do |t|
    t.integer  "client"
    t.integer  "coach"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "from"
    t.integer  "to"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_preferences", force: :cascade do |t|
    t.string   "notification_reason"
    t.string   "notification_type"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "client"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.text     "body"
    t.string   "author"
    t.string   "url_for_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "resource_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "resource_string"
    t.integer  "resource_type_id"
    t.string   "tag_1"
    t.string   "tag_2"
    t.string   "tag_3"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_a_coach"
    t.boolean  "is_an_admin"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sms_phone_number",       limit: 8
    t.boolean  "is_active"
    t.boolean  "is_deleted"
    t.boolean  "is_super_admin"
    t.integer  "company_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
