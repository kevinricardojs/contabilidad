class Cuenta < ActiveRecord::Base
  belongs_to :partida
  belongs_to :libro_diario
  belongs_to :balance
  before_create :make_nombre_
  before_create :take_libro_diario
  before_create :tomar_balance
  before_create :mi_mes
  #validates :balance_id, presence: true

  def take_libro_diario
    self.libro_diario_id = self.partida.libro_diario_id
  end

  def make_nombre_
    self.nombre_ = self.nombre.downcase.split(" ").join("_")
  end

  def tomar_balance
    self.balance_id = self.partida.libro_diario.balance_id
  end

  def mi_mes
    self.mes = self.libro_diario.mes
  end
end
