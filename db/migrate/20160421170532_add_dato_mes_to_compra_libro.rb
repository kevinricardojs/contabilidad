class AddDatoMesToCompraLibro < ActiveRecord::Migration
  def change
    add_column :compra_libros, :dato_mes, :string
  end
end
