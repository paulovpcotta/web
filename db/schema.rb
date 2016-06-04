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

ActiveRecord::Schema.define(version: 20160522024801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.text     "main"
    t.string   "complement"
    t.integer  "num"
    t.integer  "cep"
    t.integer  "city_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "district"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.string   "icon"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories", ["active"], name: "index_categories_on_active", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["active"], name: "index_cities_on_active", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "districts", ["active"], name: "index_districts_on_active", using: :btree
  add_index "districts", ["city_id"], name: "index_districts_on_city_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "phone"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professional_city_coverages", force: :cascade do |t|
    t.integer  "professional_id"
    t.integer  "city_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "professional_city_coverages", ["city_id", "professional_id"], name: "idx_city_professional", using: :btree
  add_index "professional_city_coverages", ["city_id"], name: "index_professional_city_coverages_on_city_id", using: :btree
  add_index "professional_city_coverages", ["created_at"], name: "index_professional_city_coverages_on_created_at", using: :btree
  add_index "professional_city_coverages", ["professional_id"], name: "index_professional_city_coverages_on_professional_id", using: :btree

  create_table "professional_district_coverages", force: :cascade do |t|
    t.integer  "professional_id"
    t.integer  "district_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "professional_district_coverages", ["created_at"], name: "index_professional_district_coverages_on_created_at", using: :btree
  add_index "professional_district_coverages", ["district_id", "professional_id"], name: "idx_district_professional", using: :btree
  add_index "professional_district_coverages", ["district_id"], name: "index_professional_district_coverages_on_district_id", using: :btree
  add_index "professional_district_coverages", ["professional_id"], name: "index_professional_district_coverages_on_professional_id", using: :btree

  create_table "professional_profession_images", force: :cascade do |t|
    t.string   "subtitle"
    t.integer  "professional_profession_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "photo_content"
  end

  add_index "professional_profession_images", ["professional_profession_id"], name: "idx_serv_img_on_serv_ad_id", using: :btree

  create_table "professional_professions", force: :cascade do |t|
    t.integer  "professional_id"
    t.integer  "profession_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "professional_services", force: :cascade do |t|
    t.boolean  "active"
    t.decimal  "price"
    t.integer  "service_id"
    t.integer  "service_unit_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "excluded_at"
    t.integer  "professional_id"
  end

  add_index "professional_services", ["active", "service_id", "professional_id"], name: "idx_active_service_professional", using: :btree
  add_index "professional_services", ["active", "service_id"], name: "idx_active_service", using: :btree
  add_index "professional_services", ["active"], name: "index_professional_services_on_active", using: :btree
  add_index "professional_services", ["created_at"], name: "index_professional_services_on_created_at", using: :btree
  add_index "professional_services", ["excluded_at"], name: "index_professional_services_on_excluded_at", using: :btree
  add_index "professional_services", ["service_id", "professional_id"], name: "idx_service_professional", using: :btree
  add_index "professional_services", ["service_id"], name: "index_professional_services_on_service_id", using: :btree
  add_index "professional_services", ["service_unit_id"], name: "index_professional_services_on_service_unit_id", using: :btree

  create_table "professionals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "nothing_on_record"
    t.integer  "active"
    t.integer  "phone_id"
    t.integer  "address_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "professionals", ["active", "address_id"], name: "idx_active_address", using: :btree
  add_index "professionals", ["active", "phone_id"], name: "idx_active_phone", using: :btree
  add_index "professionals", ["active", "user_id"], name: "idx_active_user", using: :btree
  add_index "professionals", ["active"], name: "index_professionals_on_active", using: :btree
  add_index "professionals", ["created_at"], name: "index_professionals_on_created_at", using: :btree

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "professions", ["active"], name: "index_professions_on_active", using: :btree

  create_table "service_professional_feedbacks", force: :cascade do |t|
    t.integer  "professional_service_id"
    t.integer  "quantity_stars"
    t.integer  "user_id"
    t.string   "feedback"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "service_units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "services", ["active", "category_id"], name: "index_services_on_active_and_category_id", using: :btree
  add_index "services", ["active"], name: "index_services_on_active", using: :btree
  add_index "services", ["category_id"], name: "index_services_on_category_id", using: :btree
  add_index "services", ["created_at"], name: "index_services_on_created_at", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "sign"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "phone_id"
    t.string   "gender"
    t.date     "birthday"
    t.string   "cpf"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "cities"
  add_foreign_key "cities", "states"
  add_foreign_key "districts", "cities"
  add_foreign_key "professional_city_coverages", "cities"
  add_foreign_key "professional_city_coverages", "professionals"
  add_foreign_key "professional_district_coverages", "districts"
  add_foreign_key "professional_district_coverages", "professionals"
  add_foreign_key "professional_profession_images", "professional_professions"
  add_foreign_key "professional_professions", "professionals"
  add_foreign_key "professional_professions", "professions"
  add_foreign_key "professional_services", "professionals"
  add_foreign_key "professional_services", "service_units"
  add_foreign_key "professional_services", "services"
  add_foreign_key "professionals", "addresses"
  add_foreign_key "professionals", "phones"
  add_foreign_key "professionals", "users"
  add_foreign_key "service_professional_feedbacks", "professional_services"
  add_foreign_key "service_professional_feedbacks", "users"
  add_foreign_key "services", "categories"
  add_foreign_key "users", "phones"
end
