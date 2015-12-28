class Contribuyente < ActiveRecord::Base
	has_many :establecimientos
	has_many :compra_libros
	has_many :venta_libros
	validates :nit, presence: true
	validates :nombre, 	presence: true
	validates :calle , presence: true
	validates :no_casa , presence: true
	validates :zona , presence: true
	validates :departamento , presence: true
	validates :municipio , presence: true
	validates :telefono , presence: true,
									length: {is: 8 , message:" tiene un minimo de 8 caracteres"},
									numericality:{only_integer: true , message:" solo debe contener numeros"}
end
