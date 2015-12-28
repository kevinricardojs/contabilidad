class OperacionesController < ApplicationController
	before_action :set_compras
	before_action :set_ventas
	def libro_venta
	end
	def libro_compra
	end
	private
	def set_ventas
		@ventas_por_dia = VentaLibro.order(:dia).where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).group(:dia).sum(:base)
		dias = VentaLibro.order(:dia).where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).group(:dia).count()
		@ventas = []

		dias.each do |dia|
			numero_dia = dia[0]
			cantidad_ventas = dia[1]
			if cantidad_ventas == 1
				venta_unica = VentaLibro.find_by(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).as_json
				venta_unica["min"] = venta_unica["numero"]
				venta_unica["max"] = venta_unica["numero"]
				@ventas.push venta_unica
			else 
				resumen_dia_ventas = {}
				resumen_dia_ventas['base']  = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).sum(:base)
				resumen_dia_ventas['gravado_bienes'] = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).sum(:gravado_bienes)
				resumen_dia_ventas['gravado_servicios'] = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).sum(:gravado_servicios)
				resumen_dia_ventas['exento_bienes'] = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).sum(:exento_bienes)
				resumen_dia_ventas['exento_servicios'] = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).sum(:exento_servicios)
				resumen_dia_ventas['documento'] = 'FC'
				resumen_dia_ventas['serie'] = 'A'
				resumen_dia_ventas['numero']  = 'Pendiente'
				resumen_dia_ventas['dia'] = numero_dia
				resumen_dia_ventas['mes'] = current_usuario.mes
				resumen_dia_ventas['year'] = current_usuario.year
				resumen_dia_ventas['nit'] = 'C/F'
				resumen_dia_ventas['nombre'] = "Clientes Varios"
				resumen_dia_ventas['min'] = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).minimum(:numero)
				resumen_dia_ventas['max'] = VentaLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, dia: numero_dia).maximum(:numero)
				@ventas.push resumen_dia_ventas.as_json
			end
		end
	end
	def set_compras
		@compras = CompraLibro.order(:dia).where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes)      
	end
end