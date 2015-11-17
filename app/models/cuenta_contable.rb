class CuentaContable < ActiveRecord::Base
	validates :nombre, presence: true
	validates :tipo, presence: true
	enum tipo: [:haber, :debe]
end
