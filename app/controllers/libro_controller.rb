class LibroController < ApplicationController
  before_action :set_nombres_all_cuentas
  before_action :balance_folio, except: :mayor

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
          pdf = MayorPdf.new("Libro Mayor", @libro_diario, current_usuario,@folios_mayor, current_usuario.mes, "landscape")

          paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
          #Crear o buscar el dato de cuantas paginas consumidas hay 
          meses  = %w[Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre]
          if meses.find_index(@u.mes) <= 2
            consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Enero")
          elsif meses.find_index(@u.mes) <= 5 && meses.find_index(@u.mes) >= 3
            consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Abril")
          elsif meses.find_index(@u.mes) <= 8 && meses.find_index(@u.mes) >= 4
            consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Julio")
          else
            consumido = @folios_mayor.consumidos.find_or_create_by(mes: "Octubre")
          end
          # Actualizar!
          consumido.update!(pag_usadas: paginas.to_i)

          send_data pdf.render, filename: "mayor_" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.mes + ".pdf",
          type: "application/pdf",
          disposition: "inline"
        end
      end
    end
  end

  def balance_primer_periodo
    @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:1, year: current_usuario.year)
    respond_to do |format|
      format.html { @current_balance } 
      format.pdf do
        pdf = BalancePdf.new("Balance General de Cuentas",@current_balance, current_usuario, @folios_balance, 1, "portrait")

        paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
        #Crear o buscar el dato de cuantas paginas consumidas hay 
        consumido = @folios_balance.consumidos.find_or_create_by(mes: "Enero")
        # Actualizar!
        consumido.update!(pag_usadas: paginas.to_i)

        send_data pdf.render, filename: "balance_primer_periodo_" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.year + ".pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def balance_segundo_periodo
    @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:2, year: current_usuario.year)
    respond_to do |format|
      format.html { @current_balance } 
      format.pdf do
        pdf = BalancePdf.new("Balance General de Cuentas", @current_balance, current_usuario, @folios_balance, 2, "portrait")
        paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
        #Crear o buscar el dato de cuantas paginas consumidas hay 
        consumido = @folios_balance.consumidos.find_or_create_by(mes: "Abril")
        # Actualizar!
        consumido.update!(pag_usadas: paginas.to_i)
        send_data pdf.render, filename: "balance.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def balance_tercer_periodo
    @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:3, year: current_usuario.year)
    respond_to do |format|
      format.html { @current_balance } 
      format.pdf do
        pdf = BalancePdf.new("Balance General de Cuentas", @current_balance, current_usuario, @folios_balance, 3, "portrait")
        paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
        #Crear o buscar el dato de cuantas paginas consumidas hay 
        consumido = @folios_balance.consumidos.find_or_create_by(mes: "Julio")
        # Actualizar!
        consumido.update!(pag_usadas: paginas.to_i)
        send_data pdf.render, filename: "balance.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def balance_cuarto_periodo
    @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:4, year: current_usuario.year)
    respond_to do |format|
      format.html { @current_balance } 
      format.pdf do
        pdf = BalancePdf.new("Balance General de Cuentas", @current_balance, current_usuario, @folios_balance, 4, "portrait")
        paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
        #Crear o buscar el dato de cuantas paginas consumidas hay 
        consumido = @folios_balance.consumidos.find_or_create_by(mes: "Octubre")
        # Actualizar!
        consumido.update!(pag_usadas: paginas.to_i)
        send_data pdf.render, filename: "balance.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  private

  def set_nombres_all_cuentas
    @cuentas = Cuenta.all.group(:nombre_).count
  end

  def balance_folio
    if @folios_balance == nil
      pdf = ErrorPdf.new
      send_data pdf.render, filename: "balance.pdf",
      type: "application/pdf",
      disposition: "inline"
    end
  end
end
