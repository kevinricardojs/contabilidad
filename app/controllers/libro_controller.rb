class LibroController < ApplicationController
  before_action :set_nombres_all_cuentas

  def mayor
    @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:@periodo, year: current_usuario.year)
    respond_to do |format|
      format.html 
      format.pdf do 
        pdf = MayorPdf.new("Libro Mayor", @libro_diario, current_usuario,10, 50, current_usuario.mes, "landscape" )
        send_data pdf.render, filename: "mayor_" + @u.establecimiento.nombre.split(" ").join("_") + "_" + @u.mes + ".pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def balance_primer_periodo
    @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:1, year: current_usuario.year)
    respond_to do |format|
      format.html { @current_balance } 
      format.pdf do
        pdf = BalancePdf.new("Balance General de Cuentas",@current_balance, current_usuario,10, 50, 1, "portrait")
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
        pdf = BalancePdf.new("Balance General de Cuentas", @current_balance, current_usuario,10, 50, 2, "portrait")
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
        pdf = BalancePdf.new("Balance General de Cuentas", @current_balance, current_usuario,10, 50, 3, "portrait")
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
        pdf = BalancePdf.new("Balance General de Cuentas", @current_balance, current_usuario,10, 50, 4, "portrait")
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
end
