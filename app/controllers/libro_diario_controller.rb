class LibroDiarioController < ApplicationController
  before_action :partidas_libro, only: :resumen

  # Accion Partidas que busca o crea la partida 1 && 2
  def partidas
    @partida = @libro_diario.partidas.new
    @partida.cuentas.build
  end

  # Accion resumen solo para ver las partidas creadas
  def resumen

  end

  private

  def partidas_libro
    @partidas_libro_diario  = @libro_diario.partidas.order(:numero_partida)
  end


end
