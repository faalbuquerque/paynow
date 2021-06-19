class CreateBilletMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :billet_methods do |t|
      t.string :name
      t.string :icon
      t.string :tax_charge
      t.string :tax_max
      t.string :available
      t.string :code_bank
      t.string :agency_bank
      t.string :account_number
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
