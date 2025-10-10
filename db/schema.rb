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

ActiveRecord::Schema[8.0].define(version: 2025_10_10_074514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "promotions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "value"
    t.string "description"
    t.string "code"
    t.boolean "is_used", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expire_date"
    t.index ["code"], name: "index_promotions_on_code", unique: true
    t.index ["user_id"], name: "index_promotions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "full_name"
    t.string "line_user_id"
    t.integer "month_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_received_promotion_this_year", default: false
  end

  add_foreign_key "promotions", "users"
end
