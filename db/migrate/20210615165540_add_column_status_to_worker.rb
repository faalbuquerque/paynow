class AddColumnStatusToWorker < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :status, :integer, default: 0, null: false
  end
end
