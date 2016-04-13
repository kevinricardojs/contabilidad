class Cuenta < ActiveRecord::Base
  belongs_to :partida
  belongs_to :libro_diario
  before_create :make_nombre_
  before_create :take_libro_diario

  
  def take_libro_diario
    self.libro_diario_id = self.partida.libro_diario_id
  end
  def make_nombre_
  self.nombre_ = self.nombre.downcase.split(" ").join("_")
  end
end
