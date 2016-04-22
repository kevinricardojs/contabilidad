class Contribuyente < ActiveRecord::Base
	has_many :establecimientos, dependent: :destroy
	has_many :compra_libros, dependent: :destroy
	has_many :venta_libros, dependent: :destroy
	has_many :usuarios

	validates :nit, presence: true, uniqueness: true
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
