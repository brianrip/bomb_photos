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

ActiveRecord::Schema.define(version: 20160328213854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "order_photos", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_photos", ["order_id"], name: "index_order_photos_on_order_id", using: :btree
  add_index "order_photos", ["photo_id"], name: "index_order_photos_on_photo_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",      default: 0
    t.integer  "total_price"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "active",             default: true
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "studio_id"
    t.integer  "category_id"
  end

  add_index "photos", ["category_id"], name: "index_photos_on_category_id", using: :btree
  add_index "photos", ["studio_id"], name: "index_photos_on_studio_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studio_orders", force: :cascade do |t|
    t.integer  "studio_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "studio_orders", ["order_id"], name: "index_studio_orders_on_order_id", using: :btree
  add_index "studio_orders", ["studio_id"], name: "index_studio_orders_on_studio_id", using: :btree

  create_table "studios", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status"
    t.string   "promo_image_file_name"
    t.string   "promo_image_content_type"
    t.integer  "promo_image_file_size"
    t.datetime "promo_image_updated_at"
    t.string   "slug"
  end

  create_table "user_photos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  add_index "user_photos", ["photo_id"], name: "index_user_photos_on_photo_id", using: :btree
  add_index "user_photos", ["user_id"], name: "index_user_photos_on_user_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "studio_id"
  end

  add_index "users", ["studio_id"], name: "index_users_on_studio_id", using: :btree

  add_foreign_key "order_photos", "orders"
  add_foreign_key "order_photos", "photos"
  add_foreign_key "orders", "users"
  add_foreign_key "photos", "categories"
  add_foreign_key "photos", "studios"
  add_foreign_key "studio_orders", "orders"
  add_foreign_key "studio_orders", "studios"
  add_foreign_key "user_photos", "photos"
  add_foreign_key "user_photos", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "studios"
end
