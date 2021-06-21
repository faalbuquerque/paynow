class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.decimal :amount, default: 0, null: false
      t.integer :payment_type, default: 0, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
