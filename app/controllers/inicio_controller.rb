class InicioController < ApplicationController
  def index
  end
  def contribuyentes
  	respond_to do |format|
  		@contribuyentes = Contribuyente.all
  		format.json{ @contribuyentes}
  	end
  end
  def establecimientos
  	@establecimientos = Establecimiento.where(contribuyente_id: params[:id])
  	respond_to do |format|
  		format.json{ @contribuyentes}
  	end
  end
  
end
