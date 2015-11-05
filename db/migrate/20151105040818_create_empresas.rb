class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nombre
      t.string :direccion
      t.integer :zona
      t.string :nit
      t.string :telefono

      t.timestamps null: false
    end
  end
end
