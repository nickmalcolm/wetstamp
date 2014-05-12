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

ActiveRecord::Schema.define(version: 20140512094135) do

  create_table "product_images", force: true do |t|
    t.integer  "product_id"
    t.integer  "shopify_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.integer  "shop_id"
    t.integer  "shopify_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["shop_id"], name: "index_products_on_shop_id", using: :btree

  create_table "shops", force: true do |t|
    t.string   "domain"
    t.string   "name"
    t.integer  "shopify_id"
    t.string   "api_password"
    t.string   "email"
    t.string   "owner"
    t.string   "notifier_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamps", force: true do |t|
    t.integer  "shop_id"
    t.string   "name"
    t.string   "image"
    t.decimal  "rotate",       precision: 5, scale: 2
    t.decimal  "transparency", precision: 3, scale: 2
    t.integer  "position"
    t.boolean  "tiled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stamps", ["shop_id"], name: "index_stamps_on_shop_id", using: :btree

end
