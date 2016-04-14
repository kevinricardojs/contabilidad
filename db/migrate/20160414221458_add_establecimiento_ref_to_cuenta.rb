class AddEstablecimientoRefToCuenta < ActiveRecord::Migration
  def change
    add_reference :cuentas, :establecimiento, index: true, foreign_key: true
  end
end
