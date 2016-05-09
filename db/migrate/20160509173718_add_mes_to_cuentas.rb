class AddMesToCuentas < ActiveRecord::Migration
  def change
    add_column :cuentas, :mes, :integer
  end
end
