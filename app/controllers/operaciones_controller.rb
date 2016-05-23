class OperacionesController < ApplicationController
	before_action :find_libro_v
	before_action :set_compras
	before_action :set_ventas
	before_action :set_por_cuentas

	def libro_venta
		if @folios_ventas == nil
			pdf = ErrorPdf.new
			send_data pdf.render, filename: "ventas.pdf",
			type: "application/pdf",
			disposition: "inline"
		else

			@iva = VentaLibro.where(libro_v_id: @libro_v).sum(:iva)
			@base = VentaLibro.where(libro_v_id: @libro_v).sum(:base)
			@bienes = (VentaLibro.where(libro_v_id: @libro_v).sum(:gravado_bienes).to_f / 1.12).round(2)
			@servicios = (VentaLibro.where(libro_v_id: @libro_v).sum(:gravado_servicios).to_f / 1.12).round(2)
			@total = @base + @iva
			respond_to do |format|
				format.html
				format.pdf do

					# Parametros suma de iva, suma de base, suma de bienes, suma de servicios,
					# => suma total, todas las ventas, current_usuario y el folio del actual año!
					pdf = VentasPdf.new(@iva, @base, @bienes, @servicios, @total, @ventas, @u, @folios_ventas)

					# Guardar en variable "pagina" el total de hojas usadas
					paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
					#Crear o buscar el dato de cuantas paginas consumidas hay
					consumido = @folios_ventas.consumidos.find_or_create_by(mes: @u.mes)
					# Actualizar!
					consumido.update!(pag_usadas: paginas.to_i)

					# Render del pdf
					send_data pdf.render, filename: "Libro_de_Ventas_" + current_usuario.establecimiento.nombre.split(" ").join("_") + "_" + current_usuario.mes + "_" + current_usuario.year + ".pdf",
					type: "application/pdf",
					disposition: "inline"

				end
			end
		end
	end
	def libro_compra
		if @folios_compras == nil
			flash.now[:alert] = "Debes Registrar los Folios de este Libro"
			pdf = ErrorPdf.new
			send_data pdf.render, filename: "compras.pdf",
			type: "application/pdf",
			disposition: "inline"
		else
			@iva = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:iva)
			@base = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).sum(:base)
			@compras_por_dia = @compras.order(:dia)
			@total = @base + @iva
			@total_cuentas = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).count

			respond_to do |format|
				format.html
				format.pdf do
					pdf = ComprasPdf.new(@iva, @base, @compras_por_dia, @total, @total_cuentas, @u, @compras_por_cuenta, @folios_compras)
					send_data pdf.render, filename: "Libro_de_Compras_" + current_usuario.establecimiento.nombre.split(" ").join("_") + "_" + current_usuario.mes + "_" + current_usuario.year + ".pdf",
					type: "application/pdf",
					disposition: "inline"

					# Guardar en variable "pagina" el total de hojas usadas
					paginas = (pdf.number_pages "<total>",color:'FFFFFF').to_s.split("..")[1]
					#Crear o buscar el dato de cuantas paginas consumidas hay
					consumido = @folios_compras.consumidos.find_or_create_by(mes: @u.mes)
					# Actualizar!
					consumido.update!(pag_usadas: paginas.to_i)

					consumido = @folios_compras.consumidos.find_or_create_by(mes: current_usuario.mes)
					consumido.update!(pag_usadas: paginas.to_i)
				end
			end
		end
	end

	private


	def set_ventas
		@ventas_por_dia = VentaLibro.order(:dia).where(libro_v_id: @libro_v).group(:dia).sum(:base)
		dias = VentaLibro.order(:serie).where(libro_v_id: @libro_v).group(:dia).count()
		series = VentaLibro.order(:serie).where(libro_v_id: @libro_v).group(:serie).count()
		@ventas = []

		dias.each do |dia|
			numero_dia = dia[0]
			cantidad_ventas = dia[1]
			if cantidad_ventas == 1
				venta_unica = VentaLibro.find_by(libro_v_id: @libro_v, dia: numero_dia).as_json
				venta_unica["min"] = venta_unica["numero"]
				venta_unica["max"] = venta_unica["numero"]
				@ventas.push venta_unica
			else
				series.each do |serie|
					resumen_dia_ventas = {}
					resumen_dia_ventas['base']  = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).sum(:base)
					resumen_dia_ventas['gravado_bienes'] = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).sum(:gravado_bienes)
					resumen_dia_ventas['gravado_servicios'] = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).sum(:gravado_servicios)
					resumen_dia_ventas['exento_bienes'] = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).sum(:exento_bienes)
					resumen_dia_ventas['exento_servicios'] = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).sum(:exento_servicios)
					resumen_dia_ventas['documento'] = 'FC'
					resumen_dia_ventas['numero']  = 'Pendiente'
					resumen_dia_ventas['dia'] = numero_dia
					resumen_dia_ventas['mes'] = current_usuario.mes
					resumen_dia_ventas['year'] = current_usuario.year
					resumen_dia_ventas['nit'] = 'C/F'
					resumen_dia_ventas['nombre'] = "Clientes Varios"
					resumen_dia_ventas['min'] = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).minimum(:numero)
					resumen_dia_ventas['max'] = VentaLibro.where(libro_v_id: @libro_v, dia: numero_dia, serie: serie).maximum(:numero)
					resumen_dia_ventas['serie'] = serie[0]

					@ventas.push resumen_dia_ventas.as_json
				end
				end
			end
			return @ventas
		end

		def set_por_cuentas
			cuentas = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes).group(:tipo_de_gasto_id).count()
			@compras_por_cuenta = []

			cuentas.each do |cuenta|
				nombre_cuenta = TipoDeGasto.find_by_id(cuenta[0]).nombre
				suma_base = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes, tipo_de_gasto_id: cuenta[0]).sum(:base)
				@compras_por_cuenta.push [nombre_cuenta , suma_base]
			end
		end

		def set_compras
			@compras = CompraLibro.where(establecimiento_id: current_usuario.establecimiento_id, mes: current_usuario.mes)
		end
	end

