class CreateBilletBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billet_billings do |t|
      t.string :company_token
      t.string :product_token
      t.string :client_token
      t.string :client_name
      t.string :client_surname
      t.string :client_cpf
      t.string :payment_method
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :street
      t.string :house_number
      t.string :complement
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
