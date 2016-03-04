class LibroDiarioController < ApplicationController
  before_action :set_libro_diario
  before_action :partidas_libro, only: :resumen

  def partidas
    @partida = @libro_diario.partidas.new
  end

  def resumen

    ventas_base = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
    ventas_iva = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
    ventas_caja = ventas_base + ventas_iva
    compras_base = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
    compras_iva = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
    compras_caja = compras_base + compras_iva


    partida1 = @libro_diario.partidas.find_by(numero_partida: 1)
    if partida1 == nil
      partida1 = @libro_diario.partidas.new  
      partida1.numero_partida = 1
      partida1.establecimiento_id = @libro_diario.establecimiento_id
      partida1.ventas = ventas_base
      partida1.iva_credito_fiscal = ventas_iva
      partida1.caja_d = ventas_caja
      partida1.descripcion = "No hay Descripción"
      partida1.save 
      @partida_1 = partida1
    else
      @partida_1 = partida1
    end
    
    partida2 = @libro_diario.partidas.find_by(numero_partida: 2)
    if partida2 == nil
      partida2 = @libro_diario.partidas.new    
      partida2.numero_partida = 2
      partida2.establecimiento_id = @libro_diario.establecimiento_id
      partida2.compras = compras_base
      partida2.iva_credito_fiscal = compras_iva
      partida2.caja_h = compras_caja
      partida2.descripcion = "No hay Descripción"
      partida2.save 
      @partida_2 = partida2
    else
      @partida_2 = partida2
    end

  end

  private
  def partidas_libro
    @partidas_libro_diario  = @libro_diario.partidas
  end

end
