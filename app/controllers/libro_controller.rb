class LibroController < ApplicationController
 before_action :set_nombres_all_cuentas

 def mayor
 end

 def balance_primer_periodo
  @current_balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id, periodo:1, year: current_usuario.year)
  respond_to do |format|
    format.html { @current_balance } 
    format.pdf do
      pdf = BalancePdf.new(@current_balance, current_usuario,10, 50, 1 )
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
    pdf = BalancePdf.new(@current_balance, current_usuario,10, 50, 2)
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
    pdf = BalancePdf.new(@current_balance, current_usuario,10, 50, 3)
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
    pdf = BalancePdf.new(@current_balance, current_usuario,10, 50, 4)
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
