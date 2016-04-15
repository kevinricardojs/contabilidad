class VentaLibro < ActiveRecord::Base
	before_save :base_iva
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

	def base_iva
		if self.gravado_bienes != "" && !self.gravado_bienes.nil?
			self.base = self.gravado_bienes.to_f / 1.12
			self.iva = self.base.to_f * 0.12
		elsif self.gravado_servicios != "" && !self.gravado_servicios.nil?
			self.base = self.gravado_servicios.to_f / 1.12
			self.iva = self.base.to_f * 0.12
		else
			self.base = 0.00
			self.iva = 0.00
		end
	end

	def total
		self.total = '%.2f' % (self.base.to_f + self.iva.to_f)
	end
end
