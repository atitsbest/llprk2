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

ActiveRecord::Schema.define(version: 20150114083303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qty",        default: 1
    t.integer  "order_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "salutation",     limit: 255
    t.string   "firstname",      limit: 255
    t.string   "name",           limit: 255
    t.string   "company",        limit: 255
    t.string   "street",         limit: 255
    t.string   "zip",            limit: 255
    t.string   "city",           limit: 255
    t.string   "country_code",   limit: 255
    t.string   "email",          limit: 255
    t.string   "pay_type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_number",                             null: false
    t.decimal  "shipping_costs",             default: 0.0
  end

  add_index "orders", ["country_code"], name: "index_orders_on_country_code", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.text     "description"
    t.string   "image_url",            limit: 255
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shipping_category_id"
  end

  create_table "shipping_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_costs", force: :cascade do |t|
    t.string   "country_id"
    t.integer  "shipping_category_id"
    t.decimal  "base"
    t.decimal  "additional"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "shipping_costs", ["country_id"], name: "index_shipping_costs_on_country_id", using: :btree
  add_index "shipping_costs", ["shipping_category_id"], name: "index_shipping_costs_on_shipping_category_id", using: :btree

  add_foreign_key "shipping_costs", "countries"
  add_foreign_key "shipping_costs", "shipping_categories"
end
