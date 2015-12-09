class AddColumnToCompraLibros < ActiveRecord::Migration
  def change
    add_reference :compra_libros, :contribuyente, index: true, foreign_key: true
    add_reference :compra_libros, :establecimiento, index: true, foreign_key: true
  end
end
