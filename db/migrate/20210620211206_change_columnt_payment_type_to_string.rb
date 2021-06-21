class ChangeColumntPaymentTypeToString < ActiveRecord::Migration[6.1]
  def change
    change_column :discounts, :payment_type, :string, default: nil
  end
end
