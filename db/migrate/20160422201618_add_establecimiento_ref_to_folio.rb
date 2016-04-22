class AddEstablecimientoRefToFolio < ActiveRecord::Migration
  def change
    add_reference :folios, :establecimiento, index: true, foreign_key: true
  end
end
