class CreateCompraLibros < ActiveRecord::Migration
  def change
    create_table :compra_libros do |t|
      t.integer :documento
      t.string :serie
      t.integer :numero
      t.integer :dia
      t.integer :mes
      t.string :year
      t.references :proveedor, index: true, foreign_key: true
      t.decimal :base, precision: 10, scale: 2
      t.decimal :iva, precision: 10, scale: 2
      t.decimal :bienes, precision: 10, scale: 2
      t.decimal :servicios, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
