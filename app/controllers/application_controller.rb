class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

before_action :authenticate_usuario!
before_action :set_user_as_u
before_action :current_period
before_action :find_libro_v
before_action :find_libro_c
before_action :set_balance
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :set_libro_diario
before_action :partidas_primarias
before_action :crear_folios


protected

def set_user_as_u
  @u = current_usuario
end


#Setear Libro Diario
def set_libro_diario
  if usuario_signed_in? && current_usuario.establecimiento_id && current_usuario.mes != "Selecciona un Mes" && current_usuario.year != "Selecciona un Año"
    establecimiento = @u.establecimiento_id
    mes = @u.mes
    year = @u.year
    libro = LibroDiario.find_by(mes: mes, year: year, balance_id: @balance.id)
    if libro != nil
      @libro_diario = libro
    else
      @libro_diario = LibroDiario.create!(balance_id: @balance.id, establecimiento_id: establecimiento, mes: mes, year: year )
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
  if usuario_signed_in? && current_usuario.establecimiento_id && current_usuario.mes != "Selecciona un Mes" && current_usuario.year != "Selecciona un Año"
    ventas_base = VentaLibro.where(libro_v_id: @libro_v).sum(:base)
    ventas_iva = VentaLibro.where(libro_v_id: @libro_v).sum(:iva)
    ventas_caja = ventas_base + ventas_iva
    compras_base = CompraLibro.where(libro_c_id: @libro_c).sum(:base)
    compras_iva = CompraLibro.where(libro_c_id: @libro_c).sum(:iva)
    compras_caja = compras_base + compras_iva


    partida1 = @libro_diario.partidas.find_by(numero_partida: 1)
    if partida1 == nil
      params = {
       partida:  {
        numero_partida: 1, dia: 1, establecimiento_id: @libro_diario.establecimiento_id,
        cuentas_attributes: [
          { nombre: "Caja", debe: ventas_caja, haber: 0.00, posicion: 1 , balance_id: @balance.id, mes: @u.mes},
          { nombre: "Ventas", debe: 0.00, haber: ventas_base, posicion: 2, balance_id: @balance.id, mes: @u.mes},
          { nombre: "Debito Fiscal", debe: 0.00, haber: ventas_iva, posicion: 3, balance_id: @balance.id, mes: @u.mes}
          ],
          descripcion: "Por favor añade una descripción"}
        }
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
        params = {
          partida:{
            numero_partida: 2, dia:1, establecimiento_id: @libro_diario.establecimiento_id,
            cuentas_attributes: [
              { nombre: "Caja", debe: 0.00, haber: compras_caja, posicion: 900, balance_id: @balance.id, mes: @u.mes},
              { nombre: "Credito Fiscal", debe: compras_iva, haber: 0.00, posicion: 899, balance_id: @balance.id, mes: @u.mes}
              ],
              descripcion: "Por favor añade una descripción"}
            }
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

      def current_period
        if usuario_signed_in?
          mes = @u.mes.to_i
          if mes == "Selecciona un Mes"
            @periodo = 0
          elsif mes >= 1 && mes <= 3
            @periodo = 1
          elsif mes >= 4 && mes <= 6
            @periodo = 2
          elsif mes >= 7 && mes <= 9
            @periodo = 3
          elsif mes >= 10 && mes <= 12
            @periodo = 4
          else
            @periodo = nil
          end
        end
      end


      def set_balance
        if usuario_signed_in? && current_usuario.establecimiento_id != nil && current_usuario.mes != "Selecciona un Mes" && current_usuario.year != "Selecciona un Año"
          @balance = Balance.find_or_create_by(establecimiento_id: current_usuario.establecimiento_id,periodo: @periodo, year: current_usuario.year )
        end
      end

      def crear_folios
        if usuario_signed_in? && current_usuario.establecimiento_id && current_usuario.mes != "Selecciona un Mes" && current_usuario.year != "Selecciona un Año"
         @folios_compras = Folio.find_by(establecimiento_id: @u.establecimiento_id, year: @u.year, libro: 0 )
         @folios_ventas = Folio.find_by(establecimiento_id: @u.establecimiento_id, year: @u.year, libro: 1)
         @folios_diario = Folio.find_by(establecimiento_id: @u.establecimiento_id, year: @u.year, libro: 2)
         @folios_mayor = Folio.find_by(establecimiento_id: @u.establecimiento_id, year: @u.year, libro: 3)
         @folios_balance = Folio.find_by(establecimiento_id: @u.establecimiento_id, year: @u.year, libro: 4 )
       end
     end

     def find_libro_v
      if usuario_signed_in? && current_usuario.establecimiento_id && current_usuario.mes != "Selecciona un Mes" && current_usuario.year != "Selecciona un Año"
        @libro_v = LibroV.find_or_create_by(establecimiento_id: @u.establecimiento_id, mes: @u.mes, year: @u.year)
      end
    end

     def find_libro_c
      if usuario_signed_in? && current_usuario.establecimiento_id && current_usuario.mes != "Selecciona un Mes" && current_usuario.year != "Selecciona un Año"
        @libro_c = LibroC.find_or_create_by(establecimiento_id: @u.establecimiento_id, mes: @u.mes, year: @u.year)
      end
    end
  end

