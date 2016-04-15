class LibroDiarioController < ApplicationController
  before_action :partidas_libro, only: :resumen

  # Accion Partidas que busca o crea la partida 1 && 2
  def partidas
    if @libro_diario
      @partida = @libro_diario.partidas.new
      @partida.cuentas.build
    else
      @partida = Partida.new
    end
  end

  # Accion resumen solo para ver las partidas creadas
  def resumen

  end

  private

  def partidas_libro
    if @libro_diario
      @partidas_libro_diario  = @libro_diario.partidas.order(:numero_partida)
    else
      @partidas_libro_diario = []
    end
  end


end
