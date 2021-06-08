class CreateBillingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_addresses do |t|
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :street
      t.string :house_number
      t.string :complement
      t.string :country
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
