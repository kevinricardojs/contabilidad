class AddPeriodoToCuentas < ActiveRecord::Migration
  def change
    add_column :cuentas, :periodo, :integer
  end
end
