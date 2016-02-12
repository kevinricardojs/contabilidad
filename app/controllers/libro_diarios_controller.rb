class LibroDiariosController < ApplicationController
  before_action :set_libro_diario, only: [:mostrar, :resumen]
  def mostrar
    @partidas = @libro_diario.partidas
  end

  def update
  end

  def destroy
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

  def set_libro_diario
    establecimiento = current_usuario.establecimiento_id
    mes = current_usuario.mes
    year = current_usuario.year
    buscar_libro = LibroDiario.find_by(establecimiento_id: establecimiento, mes: mes, year: year)
    if buscar_libro == nil
      nuevo_diario = LibroDiario.new(establecimiento_id: establecimiento, mes: mes, year: year)  
      nuevo_diario.save
      @libro_diario = nuevo_diario
    else
      @libro_diario = buscar_libro
    end

  end
end
