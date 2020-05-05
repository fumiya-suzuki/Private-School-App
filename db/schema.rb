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

ActiveRecord::Schema.define(version: 2020_05_03_124855) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.integer "c_one"
    t.integer "c_two"
    t.integer "k_one"
    t.integer "k_two"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "teacher_id"
    t.string "subject"
    t.string "note"
    t.integer "admin_confirm", default: 0
    t.datetime "day"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "change"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.date "day"
    t.integer "types"
    t.integer "english"
    t.integer "math"
    t.integer "japanese"
    t.integer "science"
    t.integer "society"
    t.text "comment"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.string "school"
    t.string "tel"
    t.boolean "admin", default: false
    t.boolean "teacher", default: false
    t.string "student"
    t.string "boolean"
    t.integer "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "image"
    t.index ["number"], name: "index_users_on_number", unique: true
  end

end
