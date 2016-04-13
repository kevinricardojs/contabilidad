class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#  before_action :operacion_cambio

before_action :authenticate_usuario!
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :set_user_as_u


protected

def set_user_as_u
  @u = current_usuario
end


#Setear Libro Diario
def set_libro_diario
  if usuario_signed_in?
    establecimiento = @u.establecimiento_id
    mes = @u.mes
    year = @u.year
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

  #Login con username
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username,:nombre, :apellido,:contribuyente_id, :establecimiento_id, :email, :mes, :year, :password, :password_confirmation, :current_password) }
  end

  def validar_datos_para_trabajar
    u = @u

    if u.contribuyente_id == nil
      flash.now[:alert] = 'No has Seleccionado ningun Contribuyente para trabajar!'
    elsif u.establecimiento_id == nil
      flash.now[:alert] = 'No has Seleccionado ningun Establecimiento para trabajar!'
    elsif u.mes == "Selecciona un Mes"
      flash.now[:alert] = 'No has Seleccionado ningun Mes para trabajar!'
    elsif u.year == "Selecciona un Año"
      flash.now[:alert] = 'No has Seleccionado ningun Año para trabajar!'
    end
  end

  def partidas_primarias
    ventas_base = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
    ventas_iva = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
    ventas_caja = ventas_base + ventas_iva
    compras_base = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
    compras_iva = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
    compras_caja = compras_base + compras_iva


    partida1 = @libro_diario.partidas.find_by(numero_partida: 1)
    if partida1 == nil
      params = { partida:{numero_partida: 1, dia: 1,establecimiento_id: @libro_diario.establecimiento_id, cuentas_attributes: [{ nombre: "Caja", debe: ventas_caja, haber: 0.00, posicion: 1 },{ nombre: "Ventas", debe: 0.00, haber: ventas_base, posicion: 2 },{ nombre: "Iva por Pagar", debe: 0.00, haber: ventas_iva, posicion: 3 }],descripcion: "Por favor añade una descripción"}}
      partida1 = @libro_diario.partidas.new(params[:partida])
      partida1.save
    else
      caja = partida1.cuentas.find_by(posicion: 1)
      ventas = partida1.cuentas.find_by(posicion: 2)
      iva = partida1.cuentas.find_by(posicion: 3)
      caja.debe = ventas_caja
      ventas.haber = ventas_base
      iva.haber = ventas_iva
      caja.save
      ventas.save
      iva.save
    end

    partida2 = @libro_diario.partidas.find_by(numero_partida: 2)
    if partida2 == nil
      params = { partida:{numero_partida: 2, dia:1, establecimiento_id: @libro_diario.establecimiento_id, cuentas_attributes: [{ nombre: "Caja", debe: 0.00, haber: compras_caja, posicion: 900 },{ nombre: "Iva por cobrar", debe: compras_iva, haber: 0.00, posicion: 899 }],descripcion: "Por favor añade una descripción"}}
      partida2 = @libro_diario.partidas.new(params[:partida])
      partida2.save
    else
      caja2 = partida2.cuentas.find_by(posicion: 900)
      iva2 = partida2.cuentas.find_by(posicion: 899)
      caja2.haber = compras_caja
      iva2.debe = compras_iva
      caja2.save
      iva2.save
    end

  end

end

