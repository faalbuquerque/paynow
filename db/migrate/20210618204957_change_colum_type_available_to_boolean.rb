class ChangeColumTypeAvailableToBoolean < ActiveRecord::Migration[6.1]
  def change
    change_column :card_methods, :available, :boolean , default: false
    change_column :pix_methods, :available, :boolean , default: false
    change_column :billet_methods, :available, :boolean , default: false
  end
end
