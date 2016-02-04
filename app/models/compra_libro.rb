class CompraLibro < ActiveRecord::Base
  #Callback
  before_validation :self_proveedor_id
  before_validation :self_tipo_de_gasto
  before_save :suma_total

  attr_accessor :proveedor_nit
  attr_accessor :proveedor_nombre
  attr_accessor :tipo_de_gasto
  #Asociaciones
  belongs_to :proveedor
  belongs_to :contribuyente
  belongs_to :establecimiento
  belongs_to :cuenta_contable
  belongs_to :tipo_de_gasto

  #Validaciones
  enum documento: %w{DA FA FC FE FO NC ND}
  validates :documento , presence: true
  validates :serie, presence: true
  validates :numero, presence: true, numericality:true
  validates :dia, presence: true, numericality:true
  validates :mes, presence: true
  validates :year, presence: true, numericality:true
  validates :proveedor_id, presence: true
  validates :contribuyente_id, presence: {message: "Debes Seleccionar un Contribuyente"}
  validates :establecimiento_id, presence:{message: "Debes Seleccionar un Establecimiento"}
  validates :base, numericality: true
  validates :iva, numericality: true 
  validates :tipo_de_gasto_id, presence: true
  

  def self_proveedor_id   
    self.proveedor_id = Proveedor.find_or_create_by(nit: @proveedor_nit , nombre: @proveedor_nombre).id if @proveedor_nit.present? && @proveedor_nombre.present?  
  end

  def self_tipo_de_gasto
    self.tipo_de_gasto_id = TipoDeGasto.find_or_create_by(nombre: @tipo_de_gasto).id if @tipo_de_gasto.present?
  end
  def suma_total
    self.total = self.base + self.iva
  end
  
end
