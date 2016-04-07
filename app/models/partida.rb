class Partida < ActiveRecord::Base
	belongs_to :libro_diario
	has_many :cuentas, dependent: :destroy
	accepts_nested_attributes_for :cuentas
	validates :descripcion, presence: true

	def total
		total_d = 0
		total_h = 0
		total = {}
		self.cuentas.each do |c|
			total_d += c.debe.to_f
			total_h += c.haber.to_f
		end
		total["debe"] = total_d
		total["haber"] = total_h

		return total
	end


	# attr_accessor :solo_campos_valids

	# def solo_campos_valids
	# 	array = self.attributes.to_a
	# 	array.delete_if do |a|
	# 		 a[1].nil? || a.include?("establecimiento_id") || a.include?("created_at") || a.include?("updated_at") || a.include?("libro_diario_id")
	# 	end
	# 	return array.to_h
	# end
end
