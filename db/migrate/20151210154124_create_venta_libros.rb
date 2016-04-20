class CreateVentaLibros < ActiveRecord::Migration
  def change
    create_table :venta_libros do |t|
      t.integer :documento
      t.string :serie
      t.integer :numero
      t.integer :dia
      t.string :mes
      t.string :year
      t.string :nit
      t.string :nombre
      t.decimal :gravado_bienes, precision: 10, scale: 2
      t.decimal :gravado_servicios, precision: 10, scale: 2
      t.decimal :exento_bienes, precision: 10, scale: 2
      t.decimal :exento_servicios, precision: 10, scale: 2
      t.decimal :base, precision: 10, scale: 2
      t.decimal :iva, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
      t.references :contribuyente, index: true, foreign_key: true
      t.references :establecimiento, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
