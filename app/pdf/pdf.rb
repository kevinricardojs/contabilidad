class Pdf < Prawn::Document
	def initialize(tipo_de_libro, u, folio, periodo, orientation)
		Prawn::Font::AFM.hide_m17n_warning = true
		super(bottom_margin: 30, page_layout: orientation.to_sym, page_size: 'A4')
		define_grid(columns: 12, rows:10)
		@periodo = periodo
		@cuentas = Cuenta.all.group(:nombre_).count
		@u = u
		@folio = folio
		@comenzar = 0 + 1
		@tipo_de_libro = tipo_de_libro
		@orientation = orientation
		cabecera(@orientation)
		font "Helvetica"
	end

	def cabecera(orientation)
		dia = Time.now.strftime('%d/%m/%Y')
		hora = Time.now.strftime("%I:%M:%S %P")
		if orientation == "portrait"
			repeat(:all) do
				grid([0,0],[1,5]).bounding_box do

					text @u.contribuyente.nombre , size: 12, style: :bold, color: "333333"
					text @u.establecimiento.nombre, size: 12, style: :bold, color: "333333"

					text "Nit: #{@u.contribuyente.nit}", size: 12, style: :bold, color: "333333"
					text "Periodo: " + print_meses_periodo(@periodo), size: 9, style: :bold, color: "333333"

				end
				grid([0,10],[1,11]).bounding_box do
					text "Fecha: #{dia}", size:10, style: :normal, color: "333333"
					text "Hora: #{hora}", size:9, style: :normal, color: "333333"
				end

				grid([0,4],[1,7]).bounding_box do
					text @tipo_de_libro, size: 10, style: :bold, color: "333333", align: :center
				end

			end
		else
			repeat(:all) do
				grid([0,0],[1,3]).bounding_box do

					text @u.contribuyente.nombre , size: 12, style: :bold, color: "333333"
					text @u.establecimiento.nombre, size: 12, style: :bold, color: "333333"

					text "Nit: #{@u.contribuyente.nit}", size: 12, style: :bold, color: "333333"
					text "Periodo: " + print_meses_periodo(@periodo), size: 9, style: :bold, color: "333333"

				end
				grid([0,10],[1,11]).bounding_box do
					text "Fecha: #{dia}", size:12, style: :normal, color: "333333"
					text "Hora: #{hora}", size:10, style: :normal, color: "333333"

				end

				grid([0,4],[1,7]).bounding_box do
					text @tipo_de_libro, size: 14, style: :bold, color: "333333", align: :center
				end

			end
		end
	end
	def enumerar_paginas(orientation)
		if orientation == "portrait"
			options = {
				at: [460, 740],
				width: 150,
				page_filter: lambda{ |pg| pg <= @folio.paginas + 1 },
				start_count_at:  @comenzar,
				color: "333333"
			}
			number_pages "Folio: <page>" ,options
		else
			options = {
				at: [650, 500],
				page_filter: lambda{ |pg| pg <= @folio.paginas + 1 },
				width: 150,
				start_count_at:  @comenzar,
				color: "333333"
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

	def consumidos
		mes = @u.mes
		suma = 0
		if self.class != MayorPdf

			if mes != "Enero"
				@folio.consumidos.order(:position).each do |consumido|
					if consumido.mes == mes
						break
					else
						suma += consumido.pag_usadas
					end
				end
			end
		else
			case @periodo
			when 1
				suma += 0
			when 2
				suma += @folio.consumidos.find_by(mes: "Enero").pag_usadas
			when 3
				enero = @folio.consumidos.find_by(mes: "Enero").pag_usadas
				abril = @folio.consumidos.find_by(mes: "Abril").pag_usadas
				suma += enero + abril
			else
				enero = @folio.consumidos.find_by(mes: "Enero").pag_usadas
				abril = @folio.consumidos.find_by(mes: "Abril").pag_usadas
				julio = @folio.consumidos.find_by(mes: "Julio").pag_usadas
				suma += enero + abril + julio

			end
		end
		return suma
	end
end
