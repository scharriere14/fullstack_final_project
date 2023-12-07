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

<<<<<<< HEAD
ActiveRecord::Schema[7.1].define(version: 2023_12_06_044040) do
=======
ActiveRecord::Schema[7.1].define(version: 2023_12_06_063828) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

>>>>>>> origin/active-admin
  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "province"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "customer_first"
    t.string "customer_last"
    t.integer "address_id"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.index ["address_id"], name: "index_customers_on_address_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "product_name"
    t.integer "product_id"
    t.integer "customer_id"
    t.integer "tracking_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.float "price"
    t.integer "stock"
    t.string "scent"
    t.string "consistency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "usage"
    t.text "description"
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "customers", "addresses"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "products"
end
