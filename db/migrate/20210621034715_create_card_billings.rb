class CreateCardBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :card_billings do |t|
      t.string :company_token
      t.string :product_token
      t.string :client_token
      t.string :client_name
      t.string :client_surname
      t.string :client_cpf
      t.string :payment_method
      t.string :client_card_number
      t.string :client_card_name
      t.string :client_card_code
      t.decimal :product_original_price
      t.decimal :product_final_price
      t.decimal :payment_tax_billing
      t.decimal :payment_tax_max
      t.decimal :product_discont
      t.string :token

      t.timestamps
    end
  end
end
