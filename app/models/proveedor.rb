class Proveedor < ActiveRecord::Base
	has_many :compra_libros
	validates :nombre, presence: {message: " es requerido"}
	validates :nit, presence: {message: " es requerido"}

end
