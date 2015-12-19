class Establecimiento < ActiveRecord::Base
  belongs_to :contribuyente
  has_many :compra_libros
  has_many :venta_libros
	validates :nombre, 	presence:{message: " del Establecimiento es requerido"}
	validates :calle , presence:{message: " o Avenida es requerido"}
	validates :numero_casa , presence:{message: " es requerido"}
	validates :zona , presence:{message: " es requerido"}
	validates :departamento , presence:{message: " es requerido"}
	validates :municipio , presence:{message: " es requerido"}
	validates :telefono , presence:{message: " es requerido"},
									length: {is: 8 , message:" tiene un minimo de 8 caracteres"},
									numericality:{only_integer: true , message:" solo debe contener numeros"}
end
