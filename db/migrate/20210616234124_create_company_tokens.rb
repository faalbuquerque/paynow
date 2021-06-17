class CreateCompanyTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :company_tokens do |t|
      t.string :token
      t.integer :company_id
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
