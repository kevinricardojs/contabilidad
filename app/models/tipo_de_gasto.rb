class TipoDeGasto < ActiveRecord::Base
	has_many :compra_libros
	validates :nombre, presence: true, uniqueness: { case_sensitive: true }
end
