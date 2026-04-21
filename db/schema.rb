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

ActiveRecord::Schema[8.1].define(version: 2026_04_20_115811) do
  create_table "requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "hits", null: false
    t.integer "int1", null: false
    t.integer "int2", null: false
    t.integer "limit", null: false
    t.string "str1", null: false
    t.string "str2", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "`limit` > 0 AND `limit` <= 1000000", name: "check_limit_validity"
    t.check_constraint "int1 > 0 AND int1 <= 1000000", name: "check_int1_validity"
    t.check_constraint "int2 > 0 AND int2 <= 1000000", name: "check_int2_validity"
  end
end
