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
    respond_to do |format|
      format.html 
      format.pdf do 
        pdf = PartidasPdf.new(@partidas_libro_diario, @u)
        send_data pdf.render, filename: "partidas" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.mes + ".pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
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
