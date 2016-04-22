class Folio < ActiveRecord::Base
	has_one :establecimiento
	validates :libro, enum: %w[compras ventas mayor balance partidas]
	validates :paginas, numericality:true
end
