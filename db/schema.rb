# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_16_042321) do
  create_table "coin_details", force: :cascade do |t|
    t.integer "coin_id", null: false
    t.decimal "price"
    t.decimal "market_cap"
    t.integer "circulating_supply"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_coin_details_on_coin_id"
  end

  create_table "coin_price_histories", force: :cascade do |t|
    t.integer "coin_id", null: false
    t.decimal "price"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_coin_price_histories_on_coin_id"
  end

  create_table "coin_prices", force: :cascade do |t|
    t.integer "coin_id", null: false
    t.string "currency"
    t.decimal "price"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_coin_prices_on_coin_id"
  end

  create_table "coins", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "coin_details", "coins"
  add_foreign_key "coin_price_histories", "coins"
  add_foreign_key "coin_prices", "coins"
end
