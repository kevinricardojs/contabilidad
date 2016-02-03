class AddEstablecimientoRefToCuentaContable < ActiveRecord::Migration
  def change
    add_reference :cuenta_contables, :establecimiento, index: true, foreign_key: true
  end
end
