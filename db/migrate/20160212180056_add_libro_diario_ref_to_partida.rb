class AddLibroDiarioRefToPartida < ActiveRecord::Migration
  def change
  	add_reference :partidas, :libro_diario, index: true, foreign_key: true
  end
end
