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

ActiveRecord::Schema[7.0].define(version: 2022_11_30_084014) do
  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.integer "base_item_id"
    t.integer "child_item_id"
    t.integer "base_item_quantity"
    t.integer "child_item_quantity"
    t.integer "discount_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.boolean "availability"
    t.integer "tax_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_category_id"], name: "index_items_on_tax_category_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "total_price", precision: 10, scale: 2
    t.decimal "tax_value", precision: 10, scale: 2
    t.integer "item_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "grand_total", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_categories", force: :cascade do |t|
    t.integer "tax_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "items", "tax_categories"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
end
