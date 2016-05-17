class Establecimiento < ActiveRecord::Base
	belongs_to :contribuyente
	has_many :balances, dependent: :destroy
	has_many :compra_libros, dependent: :destroy
	has_many :venta_libros, dependent: :destroy
	has_many :usuarios
	has_many :folios



	validates :nombre, 	presence: true
	validates :calle , presence: true
	validates :numero_casa , presence: true
	validates :zona , presence: true
	validates :departamento , presence: true
	validates :municipio , presence: true
	validates :telefono , presence: true, length: {is: 8 , message:" tiene un minimo de 8 caracteres"},
	numericality:{only_integer: true , message:" solo debe contener numeros"}

	def destroy
		Usuario.where(establecimiento_id: self.id).each do |user|
			user.establecimiento_id = nil
			user.save
		end
		super()
	end

end
