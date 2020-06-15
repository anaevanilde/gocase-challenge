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

ActiveRecord::Schema.define(version: 2020_06_15_104138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: :cascade do |t|
    t.string "reference"
    t.string "purchase_channel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.string "sku"
    t.jsonb "specifications"
    t.bigint "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "reference"
    t.string "client_name"
    t.string "address"
    t.string "delivery_service"
    t.float "total_value"
    t.string "status", default: "ready"
    t.bigint "batch_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "purchase_channel"
    t.index ["batch_id"], name: "index_orders_on_batch_id"
  end

  add_foreign_key "line_items", "orders"
  add_foreign_key "orders", "batches"
end
