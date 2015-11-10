class Proveedor < ActiveRecord::Base
	validates :nombre, presence: {message: " es requerido"}
	validates :nit, presence: {message: " es requerido"}

end
