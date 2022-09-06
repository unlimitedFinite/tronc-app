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

ActiveRecord::Schema[7.0].define(version: 2022_09_06_132019) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employee_records", force: :cascade do |t|
    t.date "week_end"
    t.integer "tips"
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tronc_record_id"
    t.bigint "report_id"
    t.index ["employee_id"], name: "index_employee_records_on_employee_id"
    t.index ["report_id"], name: "index_employee_records_on_report_id"
    t.index ["tronc_record_id"], name: "index_employee_records_on_tronc_record_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "gross_tips", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false
    t.date "report_start"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "tronc_records", force: :cascade do |t|
    t.integer "gross_tips"
    t.date "week_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "report_id"
    t.bigint "user_id"
    t.index ["report_id"], name: "index_tronc_records_on_report_id"
    t.index ["user_id"], name: "index_tronc_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "employee_records", "employees"
end
