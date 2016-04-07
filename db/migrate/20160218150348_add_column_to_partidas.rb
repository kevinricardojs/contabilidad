class AddColumnToPartidas < ActiveRecord::Migration
  def change
    add_column :partidas, :descripcion, :string
  end
end
