class CreateContribuyentes < ActiveRecord::Migration
  def change
    create_table :contribuyentes do |t|
      t.string :nit
      t.string :nombre
      t.string :calle
      t.string :no_casa
      t.integer :zona
      t.string :colonia
      t.string :departamento
      t.string :municipio
      t.string :telefono

      t.timestamps null: false
    end
  end
end
