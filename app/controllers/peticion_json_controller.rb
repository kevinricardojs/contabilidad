class PeticionJsonController < ApplicationController
	def contribuyentes
		respond_to do |format|
			@contribuyentes = Contribuyente.all
			format.json { @contribuyentes}
		end
	end
	def establecimientos
		@establecimientos = Establecimiento.where(contribuyente_id: params[:id])
		respond_to do |format|
			format.json { @contribuyentes}
		end
	end
	def proveedores
		@proveedores = Proveedor.where("nit LIKE ?", "%#{params[:nit]}%")
		respond_to do |format|
			format.json {@proveedores}
		end
	end
	def tipos_de_gastos
		@tipos_de_gastos = TipoDeGasto.where("nombre LIKE ?", "%#{params[:nombre]}%")
		respond_to do |format|
			format.json { @tipos_de_gastos}		
		end
	end
end
