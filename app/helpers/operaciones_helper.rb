module OperacionesHelper
	
	def p_hora
		t = Time.now 
		t.strftime("%I:%M:%S %P")
	end

	def p_fecha
		t = Time.now 
		t.strftime("%d/%m/%Y")
	end
end
