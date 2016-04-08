class AddLibroDiarioReferenceToCuentas < ActiveRecord::Migration
  def change
    add_reference :cuentas, :libro_diario, index: true, foreign_key: true
  end
end
