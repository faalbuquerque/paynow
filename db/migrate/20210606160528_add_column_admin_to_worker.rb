class AddColumnAdminToWorker < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :admin, :boolean
  end
end
