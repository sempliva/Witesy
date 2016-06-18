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

ActiveRecord::Schema.define(version: 20160619034418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "contact_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses_customers", id: false, force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses_customers", ["address_id"], name: "index_addresses_customers_on_address_id", using: :btree
  add_index "addresses_customers", ["customer_id"], name: "index_addresses_customers_on_customer_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["role_id"], name: "index_assignments_on_role_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["name"], name: "index_customers_on_name", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "item_number"
    t.integer  "quantity"
    t.decimal  "price"
    t.date     "shipment_date"
    t.string   "description"
    t.text     "note"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["item_number"], name: "index_items_on_item_number", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "order_number"
    t.string   "shipping_mode"
    t.string   "payment_term"
    t.date     "order_date"
    t.date     "ship_by"
    t.integer  "customer_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_number"], name: "index_orders_on_order_number", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_modes", force: :cascade do |t|
    t.string   "mode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipping_modes", ["mode"], name: "index_shipping_modes_on_mode", unique: true, using: :btree

  create_table "tokens", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.boolean  "confirmed_email", default: false
    t.datetime "last_login"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
end
