class Partida < ActiveRecord::Base
	belongs_to :libro_diario
	has_many :cuentas, dependent: :destroy
	accepts_nested_attributes_for :cuentas
	#validates :dia, presence: true
	validates :descripcion, presence: true

	def total
		total_d = 0
		total_h = 0
		total = {}
		self.cuentas.each do |c|
			total_d += c.debe.to_f
			total_h += c.haber.to_f
		end
		total["debe"] = '%.2f' % total_d.round(2)
		total["haber"] = '%.2f' % total_h.round(2)

		return total
	end

end
