class OperacionController < ApplicationController
	def seleccion
		@contribuyentes = Contribuyente.all
		@establecimientos = Establecimiento.all
	end
	def establecimiento
		
	end

end
