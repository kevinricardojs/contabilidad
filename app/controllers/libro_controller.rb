class LibroController < ApplicationController
 before_action :set_nombres_all_cuentas

  def mayor
  end

  def balance_primer_periodo
    @current_balance = Balance.find_by(establecimiento_id: current_usuario.establecimiento_id, periodo:1, year: current_usuario.year)
  	respond_to do |format|
      format.html { @current_balance } 
      format.pdf do
        pdf = CreaPdf.new(@current_balance, current_usuario,10, 50)
        send_data pdf.render, filename: "balance.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def balance_segundo_periodo
  	@current_balance = Balance.find_by(establecimiento_id: current_usuario.establecimiento_id, periodo:2, year: current_usuario.year)
  end

  def balance_tercer_periodo
  	@current_balance = Balance.find_by(establecimiento_id: current_usuario.establecimiento_id, periodo:3, year: current_usuario.year)
  end

  def balance_cuarto_periodo
  	@current_balance = Balance.find_by(establecimiento_id: current_usuario.establecimiento_id, periodo:4, year: current_usuario.year)
  end

  private

  def set_nombres_all_cuentas
    @cuentas = Cuenta.all.group(:nombre_).count
  end
end
