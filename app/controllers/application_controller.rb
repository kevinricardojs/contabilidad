class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :operacion_cambio
  before_action :authenticate_usuario!  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :datos_para_operacion
  



  protected
  def operacion_cambio
    if Contribuyente.any?
      @contribuyentes = Contribuyente.all
      @establecimientos = Establecimiento.all
    end

  end

  def datos_para_operacion
    if usuario_signed_in?
      es_id = current_usuario.establecimiento_id
      con_id = current_usuario.contribuyente_id
      @dato = []
        if es_id == nil
          es_id = "Selecciona establecimiento "
          else
            es_id = Establecimiento.find_by(id: es_id).nombre
        end
         if con_id == nil
          con_id = "Selecciona contribuyente "  
          else
            con_id = Contribuyente.find_by(id: con_id).nombre
        end

      @dato = [es_id, con_id]
      else
    end
  
    
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username,:nombre, :apellido,:contribuyente_id, :establecimiento_id, :email, :mes, :year, :password, :password_confirmation, :current_password) }
  end
end
