class AddCamposToCompraLibros < ActiveRecord::Migration
  def change
    add_reference :compra_libros, :cuenta_contable, index: true, foreign_key: true
  end
end
