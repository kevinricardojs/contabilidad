class AddColumnToPartidas < ActiveRecord::Migration
  def change
    add_column :partidas, :descripcion, :string
    add_column :partidas, :caja_h, :decimal, precision: 10, scale: 2
    add_column :partidas, :caja_d, :decimal, precision: 10, scale: 2
    remove_column :partidas, :caja
  end
end
