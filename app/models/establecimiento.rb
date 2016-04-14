class Establecimiento < ActiveRecord::Base
	belongs_to :contribuyente
	belongs_to :balance
	has_many :compra_libros
	has_many :venta_libros
	has_many :usuarios

	

	validates :nombre, 	presence: true
	validates :calle , presence: true
	validates :numero_casa , presence: true
	validates :zona , presence: true
	validates :departamento , presence: true
	validates :municipio , presence: true
	validates :telefono , presence: true, length: {is: 8 , message:" tiene un minimo de 8 caracteres"},
	numericality:{only_integer: true , message:" solo debe contener numeros"}
end
