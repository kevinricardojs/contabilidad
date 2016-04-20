class Pdf < Prawn::Document
	def initialize(tipo, u, folios_consumidos, folios_max, periodo, orientation)
		super(bottom_margin: 30, page_layout: orientation.to_sym, page_size: 'A4')
		define_grid(columns: 12, rows:12)
		@periodo = periodo
		@cuentas = Cuenta.all.group(:nombre_).count
		@u = u
		@folios_consumidos = folios_consumidos.to_i
		@folios_max = folios_max.to_i
		@tipo = tipo
		@orientation = orientation
		cabecera(@orientation)
		font "Helvetica"
		
	end

	def cabecera(orientation)
		dia = Time.now.strftime('%d/%m/%Y')
		hora = Time.now.strftime("%I:%M:%S %P")
		if orientation == "portrait"
			canvas do
				bounding_box([35,820], width: 300) do

					text @u.contribuyente.nombre , size: 12, style: :bold
					text @u.establecimiento.nombre, size: 12, style: :bold

					text "Nit: #{@u.contribuyente.nit}", size: 12, style: :bold
					text "Periodo: " + print_meses_periodo(@periodo), size: 9, style: :bold

				end	
				bounding_box([480, 820], width: 200) do
					text "Fecha: #{dia}", size:12, style: :normal
					text "Hora: #{hora}", size:9, style: :normal

				end

				bounding_box([200, 820], width:200) do
					text @tipo, size: 10, style: :bold
				end
			end
		else
			canvas do
				bounding_box([35,560], width: 300) do

					text @u.contribuyente.nombre , size: 12, style: :bold
					text @u.establecimiento.nombre, size: 12, style: :bold

					text "Nit: #{@u.contribuyente.nit}", size: 12, style: :bold
					text "Periodo: " + print_meses_periodo(@periodo), size: 9, style: :bold

				end	
				bounding_box([680, 560], width: 200) do
					text "Fecha: #{dia}", size:12, style: :normal
					text "Hora: #{hora}", size:9, style: :normal

				end

				bounding_box([300, 560], width:200) do
					text @tipo, size: 14, style: :bold
				end
			end
		end
		enumerar_paginas(orientation)
	end

	def enumerar_paginas(orientation)
		if orientation == "portrait"
			options = {
				at: [480, 757],
				width: 150,
				start_count_at:  @folios_consumidos	
			}
			number_pages "Folio: <page>" ,options
		else
			options = {
				at: [650, 500],
				width: 150,
				start_count_at:  @folios_consumidos	
			}
			number_pages "Folio: <page>" ,options
		end
	end

	def print_meses_periodo(periodo)
		case periodo
		when 1
			"Enero, Febrero, Marzo del  #{@u.year}"
		when 2
			"Abril, Mayo, Junio del  #{@u.year}"
		when 3
			"Julio, Agosto, Septiembre del  #{@u.year}"
		when 4
			"Octubre, Noviembre, Diciembre del  #{@u.year}"
		else
			@u.mes
		end
	end
end