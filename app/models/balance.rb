class Balance < ActiveRecord::Base
  belongs_to :establecimiento
  has_many :libro_diarios, dependent: :destroy
  has_many :cuentas, dependent: :destroy
end
