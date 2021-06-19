class CreateCardMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :card_methods do |t|
      t.string :name
      t.string :icon
      t.string :tax_charge
      t.string :tax_max
      t.string :available
      t.string :code
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
