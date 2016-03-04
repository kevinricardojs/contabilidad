class Partida < ActiveRecord::Base
	belongs_to :libro_diario
	attr_accessor :solo_campos_valids
	validates :descripcion, presence: true

	def solo_campos_valids
		array = self.attributes.to_a
		array.delete_if do |a|
			 a[1].nil? || a.include?("id") || a.include?("establecimiento_id") || a.include?("created_at") || a.include?("updated_at") || a.include?("libro_diario_id")
		end
		return array.to_h
	end
end
