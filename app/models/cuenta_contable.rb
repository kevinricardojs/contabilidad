class CuentaContable < ActiveRecord::Base
	validates :nombre, presence: true
	enum tipo: %w{Haber Debe}
end
