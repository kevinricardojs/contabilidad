class AddLibroVRefToVentaLibros < ActiveRecord::Migration
  def change
    add_reference :venta_libros, :libro_v, index: true, foreign_key: true
  end
end
