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

ActiveRecord::Schema.define(version: 2019_01_12_100544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.string "state_code"
    t.string "zip_code"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fulfiller_products", force: :cascade do |t|
    t.bigint "fulfiller_id"
    t.bigint "product_id"
    t.integer "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fulfiller_id", "external_id"], name: "index_fulfiller_products_on_fulfiller_id_and_external_id", unique: true
    t.index ["fulfiller_id", "product_id"], name: "index_fulfiller_products_on_fulfiller_id_and_product_id", unique: true
    t.index ["fulfiller_id"], name: "index_fulfiller_products_on_fulfiller_id"
    t.index ["product_id"], name: "index_fulfiller_products_on_product_id"
  end

  create_table "fulfiller_variants", force: :cascade do |t|
    t.bigint "fulfiller_id"
    t.bigint "variant_id"
    t.bigint "printfile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sku"
    t.index ["fulfiller_id", "variant_id"], name: "index_fulfiller_variants_on_fulfiller_id_and_variant_id", unique: true
    t.index ["fulfiller_id"], name: "index_fulfiller_variants_on_fulfiller_id"
    t.index ["printfile_id"], name: "index_fulfiller_variants_on_printfile_id"
    t.index ["variant_id"], name: "index_fulfiller_variants_on_variant_id"
  end

  create_table "fulfillers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "purchase_order_id"
    t.bigint "variant_id"
    t.string "text"
    t.string "generator"
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.decimal "unit_price"
    t.index ["purchase_order_id"], name: "index_line_items_on_purchase_order_id"
    t.index ["variant_id"], name: "index_line_items_on_variant_id"
  end

  create_table "printfiles", force: :cascade do |t|
    t.integer "width"
    t.integer "height"
    t.integer "dpi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.string "status"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.decimal "shipping_fee"
    t.index ["address_id"], name: "index_purchase_orders_on_address_id"
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id"
    t.string "color"
    t.string "size"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "fulfiller_products", "fulfillers"
  add_foreign_key "fulfiller_products", "products"
  add_foreign_key "fulfiller_variants", "fulfillers"
  add_foreign_key "fulfiller_variants", "printfiles"
  add_foreign_key "fulfiller_variants", "variants"
  add_foreign_key "line_items", "purchase_orders"
  add_foreign_key "line_items", "variants"
  add_foreign_key "purchase_orders", "addresses"
  add_foreign_key "variants", "products"
end
