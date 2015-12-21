class CreateCompraLibros < ActiveRecord::Migration
  def change
    create_table :compra_libros do |t|
      t.integer :documento
      t.string :serie
      t.string :numero
      t.integer :dia
      t.string :mes
      t.string :year
      t.references :proveedor, index: true, foreign_key: true
      t.string :base
      t.string :iva
      t.string :gravado_bienes, default: "0.00"
      t.string :gravado_servicios, default: "0.00"
      t.string :exento_bienes, default: "0.00"
      t.string :exento_servicios, default: "0.00"

      t.timestamps null: false
    end
  end
end
