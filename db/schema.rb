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

ActiveRecord::Schema.define(version: 20150413035023) do

  create_table "lokasis", force: :cascade do |t|
    t.string "nama"
    t.string "penanggung_jawab"
  end

  create_table "roti_sales", force: :cascade do |t|
    t.integer "roti_id"
    t.integer "sale_id"
    t.integer "roti_amount"
    t.integer "lokasi_id"
  end

  add_index "roti_sales", ["lokasi_id"], name: "index_roti_sales_on_lokasi_id"
  add_index "roti_sales", ["roti_id"], name: "index_roti_sales_on_roti_id"
  add_index "roti_sales", ["sale_id"], name: "index_roti_sales_on_sale_id"

  create_table "rotis", force: :cascade do |t|
    t.string "nama"
    t.string "harga"
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "tanggal"
    t.integer  "total"
    t.integer  "kelebihan"
    t.integer  "kekurangan"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
