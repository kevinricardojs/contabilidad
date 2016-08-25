class LibroController < ApplicationController
  before_action :set_mes_final
  before_action :set_nombres_all_cuentas

  def mayor
    if @folios_mayor == nil
      pdf = ErrorPdf.new
      send_data pdf.render, filename: "ventas.pdf",
      type: "application/pdf",
      disposition: "inline"
    else
      @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:@periodo, year: current_usuario.year)
      respond_to do |format|
        format.html
        format.pdf do
          pdf = MayorPdf.new("Libro Mayor", @current_balance, current_usuario,@folios_mayor, @periodo, "landscape", @mes)

          # paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
          # #Crear o buscar el dato de cuantas paginas consumidas hay
          # meses  = %w[Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre]
          # if meses.find_index(@u.mes) <= 2
          #   consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Enero")
          # elsif meses.find_index(@u.mes) <= 5 && meses.find_index(@u.mes) >= 3
          #   consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Abril")
          # elsif meses.find_index(@u.mes) <= 8 && meses.find_index(@u.mes) >= 6
          #   consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Julio")
          # elsif meses.find_index(@u.mes) <= 11 && meses.find_index(@u.mes) >= 9
          #   consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Octubre")
          # end
          # # Actualizar!
          # consumido.update!(pag_usadas: paginas.to_i)

          send_data pdf.render, filename: "mayor_" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.mes + ".pdf",
          type: "application/pdf",
          disposition: "inline"
        end
      end
    end
  end

  def balance_de_saldos
    if @folios_balance == nil
      pdf = ErrorPdf.new
      send_data pdf.render, filename: "balance.pdf",
      type: "application/pdf",
      disposition: "inline"
    else
      @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, year: current_usuario.year)
      respond_to do |format|
        format.html
        format.pdf do
          pdf = BalancePdf.new("Balance de Saldos 01 de Enero al #{@nombre_mes}",@current_balance, current_usuario, @folios_balance, 1, "portrait", @mes)
          send_data pdf.render, filename: "balance_primer_periodo_" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.year + ".pdf",
          type: "application/pdf",
          disposition: "inline"
        end
      end
    end
  end

  def estado_de_resultados
    @current_balance = Balance.find_by(establecimiento_id: current_usuario.establecimiento_id, year: current_usuario.year)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadosPdf.new(@current_balance)
        send_data pdf.render, filename: "balance_primer_periodo_" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.year + ".pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end

  end


  private

  def set_nombres_all_cuentas
    @cuentas = Cuenta.all.group(:nombre_).count
  end

  def set_mes_final
    @mes = params[:mes]
    meses = ["Invalido", "31 de Enero", "28 de Febrero", "31 de Marzo", "30 de Abril", "31 de Mayo", "30 de Junio", "31 de Julio", "31 de Agosto", "30 de Septiembre", "31 de Octubre", "30 de Noviembre", "31 de Diciembre"]
    @nombre_mes = meses[@mes.to_i]
  end

end
