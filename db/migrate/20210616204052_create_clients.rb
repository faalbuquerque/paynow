class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :token
      t.string :name
      t.string :surname
      t.string :cpf

      t.timestamps
    end
  end
end
