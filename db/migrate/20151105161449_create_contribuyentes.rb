class CreateContribuyentes < ActiveRecord::Migration
  def change
    create_table :contribuyentes do |t|
      t.string :nit
      t.string :nombre
      t.string :calle
      t.string :no_casa
      t.string :apto_similar
      t.integer :zona
      t.string :colonia
      t.string :departamento
      t.string :municipio
      t.string :telefono
      t.string :fax
      t.string :apto_postal
      t.string :email

      t.timestamps null: false
    end
  end
end
