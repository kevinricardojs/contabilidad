class Proveedor < ActiveRecord::Base
	has_many :compra_libros
	
	validates :nombre, presence: true
	validates :nit, presence: true, uniqueness: true

end
