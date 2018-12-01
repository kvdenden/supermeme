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

ActiveRecord::Schema.define(version: 2018_12_01_005548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country_code"
    t.string "recipient_name"
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "printfiles", force: :cascade do |t|
    t.integer "width"
    t.integer "height"
    t.integer "dpi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "external_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_products_on_external_id", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.integer "external_id"
    t.bigint "product_id"
    t.string "color"
    t.string "size"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "printfile_id"
    t.index ["external_id"], name: "index_variants_on_external_id", unique: true
    t.index ["printfile_id"], name: "index_variants_on_printfile_id"
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "variants", "printfiles"
  add_foreign_key "variants", "products"
end
