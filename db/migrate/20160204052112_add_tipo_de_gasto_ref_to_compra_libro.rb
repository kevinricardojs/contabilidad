class AddTipoDeGastoRefToCompraLibro < ActiveRecord::Migration
  def change
    add_reference :compra_libros, :tipo_de_gasto, index: true, foreign_key: true
  end
end
