class VentaLibro < ActiveRecord::Base
	before_validation :base_iva
	before_save :nombre_nit
	belongs_to :libro_v


	enum documento: %w{DA FA FC FE FO NC ND}
	validates :documento , presence: true
	validates :serie, presence: true
	validates :numero, presence: true, numericality:true
	validates :dia, presence: true, numericality:true
	validates :mes, presence: true
	validates :year, presence: true, numericality:true
	validates :total, numericality: { greater_than: 0, message:"Debes ingresar una Cantidad Valida" }

	def base_iva
		if self.libro_v.establecimiento.contribuyente.t_contribuyente == "normal"
			suma = self.bienes.to_f + self.servicios.to_f
			self.base = (suma.to_f / 1.12).round(2)
			self.iva = (self.base.to_f * 0.12).round(2)
		else
			self.base = 0.00
			self.iva = 0.00
		end
	end
	def nombre_nit
		if self.nombre == "" && self.nit == ""
			self.nombre = nil
			self.nit = nil
		end
	end

	def total
		self.total = '%.2f' % (self.bienes.to_f + self.servicios.to_f)
	end
end
