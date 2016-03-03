class Partida < ActiveRecord::Base
	belongs_to :libro_diario

	validates :descripcion, presence: true
end
