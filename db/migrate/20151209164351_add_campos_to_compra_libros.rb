class AddCamposToCompraLibros < ActiveRecord::Migration
  def change
    add_reference :compra_libros, :cuenta_contable, index: true, foreign_key: true
    add_column :compra_libros, :total, :string
  end
end
