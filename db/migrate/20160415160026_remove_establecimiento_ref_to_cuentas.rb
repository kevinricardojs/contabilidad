class RemoveEstablecimientoRefToCuentas < ActiveRecord::Migration
  def change
    remove_reference :cuentas, :establecimiento, index: true, foreign_key: true
    remove_column :cuentas, :periodo, :integer
  end
end
