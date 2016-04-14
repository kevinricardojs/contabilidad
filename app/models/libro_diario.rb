class LibroDiario < ActiveRecord::Base
	belongs_to :establecimiento
	has_many :partidas
	has_many :cuentas

	before_create :periodo

	def periodo
		mes = self.mes
		if mes == "Selecciona un Mes"
			self.periodo = 0
		elsif mes == "Enero" || mes == "Febrero" || mes == "Marzo"
			self.periodo = 1
		elsif mes == "Abril" || mes == "Mayo" || mes == "Junio"
			self.periodo = 2 
		elsif mes == "Julio" || mes == "Agosto" || mes == "Septiembre"
			self.periodo = 3
		elsif mes == "Octubre" || mes == "Noviembre" || mes == "Diciembre"
			self.periodo = 4 
		else
			self.periodo = nil
		end
	end


end
