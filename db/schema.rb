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

ActiveRecord::Schema[7.0].define(version: 2022_12_06_172234) do
  create_table "branch_offices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.bigint "locality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locality_id"], name: "index_branch_offices_on_locality_id"
    t.index ["name"], name: "index_branch_offices_on_name", unique: true
  end

  create_table "branch_offices_schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "branch_office_id", null: false
    t.bigint "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_office_id"], name: "index_branch_offices_schedules_on_branch_office_id"
    t.index ["schedule_id"], name: "index_branch_offices_schedules_on_schedule_id"
  end

  create_table "localities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "province"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province", "name"], name: "index_localities_on_province_and_name", unique: true
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "day"
    t.time "from"
    t.time "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.time "hour"
    t.string "motive"
    t.integer "status", default: 0
    t.string "result"
    t.bigint "branch_office_id", null: false
    t.bigint "user_id", null: false
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_office_id"], name: "index_turns_on_branch_office_id"
    t.index ["employee_id"], name: "index_turns_on_employee_id"
    t.index ["user_id"], name: "index_turns_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 2
    t.bigint "branch_office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_office_id"], name: "index_users_on_branch_office_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "branch_offices", "localities"
  add_foreign_key "branch_offices_schedules", "branch_offices"
  add_foreign_key "branch_offices_schedules", "schedules"
  add_foreign_key "turns", "branch_offices"
  add_foreign_key "turns", "users"
  add_foreign_key "turns", "users", column: "employee_id"
  add_foreign_key "users", "branch_offices"
end
