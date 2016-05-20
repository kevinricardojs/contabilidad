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
  validates :year, presence: true, numericality:true
  validates :proveedor_id, presence: true
  validates :contribuyente_id, presence: true
  validates :establecimiento_id, presence: true
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
    if self.tipo_de_gasto_id
      TipoDeGasto.find_by(id: self.tipo_de_gasto_id).nombre
    end
  end

  def self_proveedor_id
    self.proveedor_id = Proveedor.find_or_create_by(nit: @proveedor_nit , nombre: @proveedor_nombre).id if @proveedor_nit.present? && @proveedor_nombre.present?
  end

  def self_tipo_de_gasto
    self.tipo_de_gasto_id = TipoDeGasto.find_or_create_by(nombre: @tipo_de_gasto).id if @tipo_de_gasto.present?
  end

  def base_iva
    if self.exento_servicios.nil? && self.exento_bienes.nil?
      suma = self.gravado_bienes.to_f + self.gravado_servicios.to_f
      self.base = (suma.to_f / 1.12).round(2)
      self.iva = (self.base.to_f * 0.12).round(2)
    else
      self.base = 0.00
      self.iva = 0.00
    end
  end

  def total
    if self.base.to_f + self.iva.to_f != 0
      self.total = '%.2f' % (self.base.to_f + self.iva.to_f)
    else
      self.total = '%.2f' % (self.exento_servicios.to_f + self.exento_bienes.to_f)
    end
  end
end
