class CreateProveedors < ActiveRecord::Migration
  def change
    create_table :proveedors do |t|
      t.string :nombre
      t.string :nit

      t.timestamps null: false
    end
  end
end
