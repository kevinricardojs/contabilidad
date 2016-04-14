class Cuenta < ActiveRecord::Base
  belongs_to :partida
  belongs_to :libro_diario
  before_create :make_nombre_
  before_create :take_libro_diario
  before_create :periodo
  before_create :establecimiento
  
  def take_libro_diario
    self.libro_diario_id = self.partida.libro_diario_id
  end

  def make_nombre_
    self.nombre_ = self.nombre.downcase.split(" ").join("_")
  end

  def periodo
    self.periodo = self.libro_diario.periodo
  end

  def establecimiento
    self.establecimiento_id = self.libro_diario.establecimiento_id
  end
end
