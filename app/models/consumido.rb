class Consumido < ActiveRecord::Base
  belongs_to :folio
  before_create :crear_position

  validates :mes, presence: true
  private
  def crear_position
  	meses = %w[Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre]
  	index = meses.find_index(self.mes)
  	self.position = index
  end
end
