# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_22_155707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employee_records", force: :cascade do |t|
    t.date "week_end"
    t.integer "tips"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tronc_record_id"
    t.bigint "report_id"
    t.index ["employee_id"], name: "index_employee_records_on_employee_id"
    t.index ["report_id"], name: "index_employee_records_on_report_id"
    t.index ["tronc_record_id"], name: "index_employee_records_on_tronc_record_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "gross_tips"
    t.integer "tax_due"
    t.integer "net_tips"
    t.integer "month"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tronc_records", force: :cascade do |t|
    t.integer "gross_tips"
    t.date "week_end"
    t.integer "tax_due"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "report_id"
    t.index ["report_id"], name: "index_tronc_records_on_report_id"
  end

  add_foreign_key "employee_records", "employees"
end
