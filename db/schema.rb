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

ActiveRecord::Schema.define(version: 2020_05_13_125421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cart_trips", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_carts_on_slug", unique: true
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.integer "remaining_uses"
    t.integer "reduction_percentage"
    t.date "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diet_travellers", force: :cascade do |t|
    t.bigint "traveller_id"
    t.bigint "food_diet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_diet_id"], name: "index_diet_travellers_on_food_diet_id"
    t.index ["traveller_id"], name: "index_diet_travellers_on_traveller_id"
  end

  create_table "food_diets", force: :cascade do |t|
    t.boolean "approved_status", default: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_restrictions", force: :cascade do |t|
    t.boolean "approved_status", default: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "order_trips", force: :cascade do |t|
    t.integer "order_id"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "total_price"
    t.boolean "payment_status", default: false
    t.string "payment_fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coupon_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.jsonb "location", default: {"lat"=>48.839155, "lng"=>2.389909}
    t.text "description"
    t.boolean "approved_status", default: false
    t.boolean "secret_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_places_on_user_id"
  end

  create_table "restriction_travellers", force: :cascade do |t|
    t.bigint "traveller_id"
    t.bigint "food_restriction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_restriction_id"], name: "index_restriction_travellers_on_food_restriction_id"
    t.index ["traveller_id"], name: "index_restriction_travellers_on_traveller_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "themes_trips", id: false, force: :cascade do |t|
    t.bigint "theme_id", null: false
    t.bigint "trip_id", null: false
    t.index ["theme_id", "trip_id"], name: "index_themes_trips_on_theme_id_and_trip_id"
    t.index ["trip_id", "theme_id"], name: "index_themes_trips_on_trip_id_and_theme_id"
  end

  create_table "travellers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.string "nationality"
    t.string "address"
    t.string "zip_code"
    t.integer "age_on_create"
    t.date "birth_date"
    t.integer "phone_number"
    t.boolean "insurance_status"
    t.bigint "cart_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_travellers_on_cart_id"
    t.index ["order_id"], name: "index_travellers_on_order_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.jsonb "arrival_location"
    t.jsonb "departure_location"
    t.date "departure_date"
    t.date "arrival_date"
    t.integer "price"
    t.integer "week"
    t.time "meetup_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.index ["season_id"], name: "index_trips_on_season_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "orders", "coupons"
  add_foreign_key "places", "users"
  add_foreign_key "trips", "seasons"
end
