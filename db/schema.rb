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

ActiveRecord::Schema.define(version: 2021_06_20_211206) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "admin_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "billet_methods", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "tax_charge"
    t.string "tax_max"
    t.boolean "available", default: false
    t.string "code_bank"
    t.string "agency_bank"
    t.string "account_number"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_billet_methods_on_company_id"
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.string "zip_code"
    t.string "state"
    t.string "city"
    t.string "street"
    t.string "house_number"
    t.string "complement"
    t.string "country"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_billing_addresses_on_company_id"
  end

  create_table "card_methods", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "tax_charge"
    t.string "tax_max"
    t.boolean "available", default: false
    t.string "code"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_card_methods_on_company_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "token"
    t.string "name"
    t.string "surname"
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj"
    t.string "corporate_name"
    t.string "billing_email"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "domain"
    t.index ["domain"], name: "index_companies_on_domain", unique: true
  end

  create_table "company_tokens", force: :cascade do |t|
    t.string "token"
    t.integer "company_id"
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_company_tokens_on_client_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.decimal "amount", default: "0.0", null: false
    t.string "payment_type", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_discounts_on_product_id"
  end

  create_table "pix_methods", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "tax_charge"
    t.string "tax_max"
    t.boolean "available", default: false
    t.string "code_bank"
    t.string "code_pix"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_pix_methods_on_company_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "product_price"
    t.string "token"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", null: false
    t.boolean "admin"
    t.integer "status", default: 0, null: false
    t.index ["company_id"], name: "index_workers_on_company_id"
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

  add_foreign_key "billet_methods", "companies"
  add_foreign_key "billing_addresses", "companies"
  add_foreign_key "card_methods", "companies"
  add_foreign_key "company_tokens", "clients"
  add_foreign_key "discounts", "products"
  add_foreign_key "pix_methods", "companies"
  add_foreign_key "products", "companies"
  add_foreign_key "workers", "companies"
end
