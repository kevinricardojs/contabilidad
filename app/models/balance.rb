class Balance < ActiveRecord::Base
  belongs_to :establecimiento
  has_many :libro_diarios
  has_many :cuentas
end
