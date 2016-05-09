class LibroDiario < ActiveRecord::Base
	belongs_to :establecimiento
	belongs_to :balance
	has_many :partidas, dependent: :destroy
	has_many :cuentas, dependent: :destroy
	validates :balance_id, presence: true



end
