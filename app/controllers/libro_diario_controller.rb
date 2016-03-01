class LibroDiarioController < ApplicationController
  before_action :set_libro_diario

  def partidas
    @partida = @libro_diario.partidas.new

  end

  def resumen
    @ventas_base = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
    @ventas_iva = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
    @ventas_caja = @ventas_base + @ventas_iva
    @compras_base = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
    @compras_iva = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
    @compras_caja = @compras_base + @compras_iva
  end

  private


end
