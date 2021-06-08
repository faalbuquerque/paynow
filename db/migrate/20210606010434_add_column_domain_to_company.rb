class AddColumnDomainToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :domain, :string
    add_index :companies, :domain, unique: true
  end
end
