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

ActiveRecord::Schema.define(version: 20160930124755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "body"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "created_by"
    t.integer  "parent_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "modify_by"
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "configs", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.text     "code"
    t.float    "percent_off"
    t.integer  "created_by"
    t.integer  "modify_by"
    t.integer  "no_of_uses"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "coupons_useds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "shipping_method"
    t.text     "awb_no"
    t.integer  "payment_gateway_id"
    t.integer  "transaction_id"
    t.integer  "status"
    t.float    "grand_total"
    t.float    "shipping_charges"
    t.integer  "coupon_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "sku"
    t.text     "short_description"
    t.text     "long_description"
    t.float    "price"
    t.float    "special_price"
    t.date     "special_price_from"
    t.date     "special_price_to"
    t.integer  "status"
    t.integer  "quantity",           default: 0
    t.text     "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.integer  "created_by"
    t.integer  "modify_by"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "category_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "totalvalue"
    t.text     "stripe_token"
    t.text     "stripe_token_type"
    t.text     "stripe_email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "user_addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "city"
    t.text     "state"
    t.text     "country"
    t.text     "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
