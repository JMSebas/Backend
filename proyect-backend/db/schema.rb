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

ActiveRecord::Schema[7.1].define(version: 2023_12_21_042131) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "adress"
    t.string "email"
    t.date "date"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "password"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["jti"], name: "index_employees_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "invoices", primary_key: "invoice_number", id: :bigint, default: -> { "nextval('invoices_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "payment_method"
    t.bigint "order_id", null: false
    t.string "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "subtotal"
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "orders", primary_key: "order_number", id: :bigint, default: -> { "nextval('orders_id_seq'::regclass)" }, force: :cascade do |t|
    t.date "date"
    t.integer "status"
    t.decimal "total"
    t.bigint "table_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_orders_on_employee_id"
    t.index ["table_id"], name: "index_orders_on_table_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "image"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "status"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "orders", primary_key: "order_number"
  add_foreign_key "items", "orders", primary_key: "order_number"
  add_foreign_key "items", "products"
  add_foreign_key "orders", "employees"
  add_foreign_key "orders", "tables"
end
