class OperacionesController < ApplicationController
	before_action :set_compras
	before_action :set_ventas
	def libro_venta
	end
	def libro_compra
	end
	private
		def set_ventas
			@ventas = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes)
		end
		def set_compras
			@compras = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes)      
		end
end
