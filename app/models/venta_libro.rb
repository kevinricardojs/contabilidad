class VentaLibro < ActiveRecord::Base
	before_save :suma_total
	
	belongs_to :contribuyente
	belongs_to :establecimiento
	enum documento: %w{DA FA FC FE FO NC ND}
	validates :documento , presence: true
	validates :serie, presence: true
	validates :numero, presence: true, numericality:true
	validates :dia, presence: true, numericality:true
	validates :mes, presence: true
	validates :year, presence: true, numericality:true
	validates :contribuyente_id, presence: {message: "Debes Seleccionar un Contribuyente"}
	validates :establecimiento_id, presence:{message: "Debes Seleccionar un Establecimiento"}
	validates :base, numericality: true
	validates :iva, numericality: true 

	
	def suma_total
		self.total = self.base + self.iva
	end
end
