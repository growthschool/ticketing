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

ActiveRecord::Schema.define(version: 20151017113904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "seat_quantity"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "is_displayed",     default: false
    t.string   "token"
    t.string   "location_name"
    t.string   "location_address"
    t.datetime "started_at"
    t.datetime "end_at"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "quantity"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "token"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name"
    t.string   "email"
    t.string   "cell_phone"
    t.integer  "total_price"
    t.string   "payment_method"
    t.datetime "paid_at"
    t.integer  "tickets_count",  default: 0
    t.datetime "expired_at"
    t.datetime "should_paid_at"
    t.datetime "canceled_at"
    t.string   "trade_number"
    t.string   "bank_code"
    t.string   "bank_no"
    t.datetime "agree_term_at"
  end

  add_index "registrations", ["trade_number"], name: "index_registrations_on_trade_number", using: :btree

  create_table "ticket_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "event_id"
    t.integer  "price"
    t.boolean  "is_displayed",                 default: true
    t.integer  "amount"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "allow_single_purchase_amount", default: 1
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "registration_id"
    t.integer  "ticket_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "price"
    t.string   "name"
    t.string   "cell_phone"
    t.string   "email"
  end

  create_table "trade_logs", force: :cascade do |t|
    t.text     "content"
    t.integer  "registration_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
