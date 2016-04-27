class Folio < ActiveRecord::Base
	has_one :establecimiento
	before_save :disponibles


	enum libro: %w{compras ventas diario mayor balance}
	validates :paginas, numericality:true

private
	def disponibles
		self.disponibles = self.paginas
	end
end
