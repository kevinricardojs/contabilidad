class Empresa < ActiveRecord::Base
	validates :nombre, presence: true, length: {minimum: 4}
	validates :direccion, presence: true, length: {minimum: 10}
	validates :nit, presence: true, length: {is: 6}
	validates :zona, presence: true, length: {in: 1..50}
	validates :telefono, presence: true, length: {is: 8}

end
