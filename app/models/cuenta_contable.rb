class CuentaContable < ActiveRecord::Base
	has_many :compra_libros
	validates :nombre, presence: true
	enum tipo: %w{Haber Debe}
	validates :tipo, presence: true
end
