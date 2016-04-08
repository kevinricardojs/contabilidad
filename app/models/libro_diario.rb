class LibroDiario < ActiveRecord::Base
  belongs_to :establecimiento
  has_many :partidas
  has_many :cuentas


end
