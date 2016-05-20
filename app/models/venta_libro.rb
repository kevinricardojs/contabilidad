class VentaLibro < ActiveRecord::Base
	before_validation :base_iva


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
	validates :total, numericality: { greater_than: 0, message:"Debes ingresar una Cantidad Valida" }

	def base_iva
		if self.exento_servicios.nil? && self.exento_bienes.nil?
			suma = self.gravado_bienes.to_f + self.gravado_servicios.to_f
			self.base = (suma.to_f / 1.12).round(2)
			self.iva = (self.base.to_f * 0.12).round(2)
		else
			self.base = 0.00
			self.iva = 0.00
		end
	end

	def total
		if self.base.to_f + self.iva.to_f != 0
			self.total = '%.2f' % (self.base.to_f + self.iva.to_f)
		else
			self.total = '%.2f' % (self.exento_servicios.to_f + self.exento_bienes.to_f)
		end
	end
end
