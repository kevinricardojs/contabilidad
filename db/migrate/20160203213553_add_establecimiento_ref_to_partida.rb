class AddEstablecimientoRefToPartida < ActiveRecord::Migration
  def change
    add_reference :partidas, :establecimiento, index: true, foreign_key: true
  end
end
