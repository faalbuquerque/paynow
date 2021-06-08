class AddReferenceCompanyToWorker < ActiveRecord::Migration[6.1]
  def change
    add_reference :workers, :company, null: false, foreign_key: true
  end
end
