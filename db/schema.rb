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

ActiveRecord::Schema.define(version: 20150326234644) do

  create_table "roti_sales", force: :cascade do |t|
    t.integer "roti_id"
    t.integer "sale_id"
    t.integer "roti_amount"
  end

  add_index "roti_sales", ["roti_id"], name: "index_roti_sales_on_roti_id"
  add_index "roti_sales", ["sale_id"], name: "index_roti_sales_on_sale_id"

  create_table "rotis", force: :cascade do |t|
    t.string "nama"
    t.string "harga"
  end

  create_table "sales", force: :cascade do |t|
    t.string "lokasi"
  end

end
