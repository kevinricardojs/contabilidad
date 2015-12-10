class CreateVentaLibros < ActiveRecord::Migration
  def change
    create_table :venta_libros do |t|
      t.integer :documento
      t.string :serie
      t.string :numero
      t.integer :dia
      t.string :mes
      t.string :year
      t.string :nit
      t.string :nombre
      t.string :gravado_bienes
      t.string :gravado_servicios
      t.string :exento_bienes
      t.string :exento_servicios
      t.string :base
      t.string :iva
      t.string :total
      t.references :contribuyente, index: true, foreign_key: true
      t.references :establecimiento, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
