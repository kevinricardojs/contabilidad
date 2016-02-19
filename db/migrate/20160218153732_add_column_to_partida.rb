class AddColumnToPartida < ActiveRecord::Migration
  def change
    add_column :partidas, :numero_partida, :integer
  end
end
