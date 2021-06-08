class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :cnpj
      t.string :corporate_name
      t.string :billing_email
      t.string :token

      t.timestamps
    end
  end
end
