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
      t.string :gravado_bienes
      t.string :gravado_servicios
      t.string :exento_bienes
      t.string :exento_servicios

      t.timestamps null: false
    end
  end
end
