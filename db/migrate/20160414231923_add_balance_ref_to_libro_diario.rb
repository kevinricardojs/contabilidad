class AddBalanceRefToLibroDiario < ActiveRecord::Migration
  def change
    add_reference :libro_diarios, :balance, index: true, foreign_key: true
    add_reference :cuentas, :balance, index: true, foreign_key: true
  end
end
