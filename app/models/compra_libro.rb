class CompraLibro < ActiveRecord::Base
  #Callback
  before_validation :self_proveedor_id

  attr_accessor :proveedor_nit
  attr_accessor :proveedor_nombre
  #Asociaciones
  belongs_to :proveedor
  belongs_to :contribuyente
  belongs_to :establecimiento

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
  validates :cuenta_contable_id, presence: true


  def self_proveedor_id   
    self.proveedor_id = Proveedor.find_or_create_by(nit: @proveedor_nit , nombre: @proveedor_nombre).id if @proveedor_nit.present? && @proveedor_nombre.present?  
  end
  
  
end
