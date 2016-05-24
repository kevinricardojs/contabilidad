class RemoveEstablecimientoRefToCompraLibros < ActiveRecord::Migration
  def change
    remove_reference :compra_libros, :establecimiento, index: true, foreign_key: true
    remove_reference :compra_libros, :contribuyente, index: true, foreign_key: true
  end
end
