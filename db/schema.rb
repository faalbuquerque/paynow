ActiveRecord::Schema.define(version: 2021_06_06_160528) do

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
    t.index ["company_id"], name: "index_workers_on_company_id"
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

  add_foreign_key "billing_addresses", "companies"
  add_foreign_key "workers", "companies"
end
