class CuentaContable < ActiveRecord::Base
	has_many :compra_libros

	enum tipo: %w{Haber Debe}
	validates :nombre, presence: true
	validates :tipo, presence: true
end
