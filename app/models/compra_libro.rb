class CompraLibro < ActiveRecord::Base
  #Callback
  before_validation :base_iva
  before_validation :self_proveedor_id
  before_validation :self_tipo_de_gasto



  attr_accessor :proveedor_nit
  attr_accessor :proveedor_nombre
  attr_accessor :tipo_de_gasto
  #Asociaciones
  belongs_to :proveedor
  belongs_to :cuenta_contable
  belongs_to :tipo_de_gasto
  belongs_to :libro_c

  #Validaciones
  enum documento: %w{DA FA FC FE FO NC ND}
  validates :documento , presence: true
  validates :serie, presence: true
  validates :numero, presence: true, numericality:true
  validates :dia, presence: true, numericality:true
  validates :year, presence: true, numericality:true
  validates :proveedor_id, presence: true
  validates :tipo_de_gasto_id, presence: true
  validates :total, numericality: { greater_than: 0, message:"Debes ingresar una Cantidad   Valida" }

  def proveedor_nit
    if Proveedor.where(id: self.proveedor_id).first != nil
      return self.proveedor.nit
    else
      return @proveedor_nit
    end
  end

  def proveedor_nombre
    if Proveedor.where(id: self.proveedor_id).first != nil
      Proveedor.find_by(id: self.proveedor_id).nombre
    else
      return @proveedor_nombre
    end
  end

  def tipo_de_gasto
    if  TipoDeGasto.find_by(id: self.tipo_de_gasto_id) != nil
      return TipoDeGasto.find_by(id: self.tipo_de_gasto_id).nombre
    else
      return @tipo_de_gasto
    end
  end

  def self_proveedor_id
    self.proveedor_id = Proveedor.find_or_create_by(nit: @proveedor_nit , nombre: @proveedor_nombre).id if @proveedor_nit.present? && @proveedor_nombre.present?
  end

  def self_tipo_de_gasto
    self.tipo_de_gasto_id = TipoDeGasto.find_or_create_by(nombre: @tipo_de_gasto).id if @tipo_de_gasto.present?
  end

  def base_iva
    if self.libro_c.establecimiento.contribuyente.t_contribuyente == "normal"
      suma = self.bienes.to_f + self.servicios.to_f
      self.base = (suma.to_f / 1.12).round(2)
      self.iva = (self.base.to_f * 0.12).round(2)
    else
      self.base = 0.00
      self.iva = 0.00
    end
  end

  def total
    self.total = '%.2f' % (self.bienes.to_f + self.servicios.to_f)
  end
end
