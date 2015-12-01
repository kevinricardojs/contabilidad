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
      @dato = []
      @dato[0] = current_usuario.establecimiento_id
      @dato[1]= current_usuario.contribuyente_id
      
        if @dato[0] == nil
          @dato[0] = "Selecciona establecimiento "
          else
            @dato[0] = Establecimiento.find_by(id: @dato[0]).nombre
        end

         if @dato[1] == nil
          @dato[1] = "Selecciona contribuyente "  
          else
            @dato[1] = Contribuyente.find_by(id: @dato[1]).nombre
        end
      else
    end
  
    
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username,:nombre, :apellido,:contribuyente_id, :establecimiento_id, :email, :mes, :year, :password, :password_confirmation, :current_password) }
  end
end
