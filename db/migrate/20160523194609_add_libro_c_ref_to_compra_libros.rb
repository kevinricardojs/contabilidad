class AddLibroCRefToCompraLibros < ActiveRecord::Migration
  def change
    add_reference :compra_libros, :libro_c, index: true, foreign_key: true
  end
end
