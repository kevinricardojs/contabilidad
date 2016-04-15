class Cuenta < ActiveRecord::Base
  belongs_to :partida
  belongs_to :libro_diario
  belongs_to :balance
  before_create :make_nombre_
  before_create :take_libro_diario
  before_create :balance
  
  def take_libro_diario
    self.libro_diario_id = @libro_diario,id
  end

  def make_nombre_
    self.nombre_ = self.nombre.downcase.split(" ").join("_")
  end

  def balance
    if @balance
      self.balance_id = @balance
    end
  end
end
