class RegistrationsController < Devise::RegistrationsController
	def edit
		@contribuyentes = Contribuyente.all
		@establecimientos = Establecimiento.all
	end
	protected

	def update_resource(resource, params)
		resource.update_without_password(params)
	end

end
