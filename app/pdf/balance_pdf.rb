class BalancePdf < Prawn::Document
	def initialize(balance, u, folios_consumidos, folios_max, periodo)
		super()
		define_grid(columns: 12, rows:12)
		@periodo = periodo
		@cuentas = @cuentas = Cuenta.all.group(:nombre_).count
		@u = u
		@folios_consumidos = folios_consumidos.to_i
		@folios_max = folios_max.to_i
		@balance = balance
		grid([1, 0], [11,9]).bounding_box do
			cuentas
		end
		cabecera
	end

	def cabecera
		dia = Time.now.strftime('%d/%m/%Y')
		hora = Time.now.strftime("%I:%M:%S %P")
		repeat(:all) do
			font "Times-Roman"
			grid([0, 0], [0,4]).bounding_box do
				text @u.contribuyente.nombre , size: 14, style: :bold
				text @u.establecimiento.nombre, size: 14, style: :bold
				text "Nit: #{@u.contribuyente.nit}", size: 14, style: :bold
				text "Periodo:" + print_meses_periodo(@periodo), size: 9, style: :bold
			end
			grid([0, 9], [0,11]).bounding_box do
				text "Fecha: #{dia}", size:12, style: :normal
				text "Hora: #{hora}", size:12, style: :normal
			end
			grid([0, 4], [0,7]).bounding_box do
				text "Balance General de Cuentas", size: 14, style: :bold
			end
		end
		enumerar_paginas
	end

	def enumerar_paginas
		options = { at: [400, 672],
			width: 150,
			start_count_at:  @folios_consumidos	}
			number_pages "Folio: <page>" ,options
		end

		def cuentas
			
			header = [ [
				{content: "", colspan: 1, border_color:"757D75"},
				{content: "Saldos", colspan: 2, align: :center, font_style: :bold, border_color: "757D75"},
				{content: "Totales", colspan: 2, align: :center, font_style: :bold, border_color: "757D75"} 
				],
				[
					{content:"Cuentas", align: :center, font_style: :bold, border_color: "757D75"},
					{content:"Debe", align: :center, font_style: :bold, border_color: "757D75"}, 
					{content:"Haber", align: :center, font_style: :bold, border_color: "757D75"},
					{content:"Debe", align: :center, font_style: :bold, border_color: "757D75"},
					{content:"Haber", align: :center, font_style: :bold, border_color: "757D75"}
				]
			]
			cuentas = []
			total_deudor = 0 
			total_acreedor = 0
			total_debe = @balance.cuentas.sum(:debe)
			total_haber = @balance.cuentas.sum(:haber)
			@cuentas.each do |cuenta|
				nombre = Cuenta.where(nombre_: cuenta[0] ).first.nombre
				debe = Cuenta.where(nombre_: cuenta[0] , balance_id: @balance).sum(:debe).to_f
				haber = Cuenta.where(nombre_: cuenta[0] , balance_id: @balance).sum(:haber).to_f
				if debe != 0.0 || haber != 0.0
					if debe.to_f < haber.to_f
						saldo_acreedor = haber.to_f - debe.to_f
						total_acreedor += saldo_acreedor
						saldo_acreedor = "Q" + '%.2f' % (saldo_acreedor)
						saldo_deudor = ""
					elsif haber.to_f < debe.to_f
						saldo_deudor = debe.to_f - haber.to_f
						total_deudor += saldo_deudor
						saldo_deudor =  "Q" + '%.2f' % (saldo_deudor)
						saldo_acreedor = ""
					else
						saldo_deudor = ""
						saldo_acreedor = ""
					end
					cuenta = [
						[ 
							{content:nombre, align: :left, borders: [:left, :right], border_width: 1, border_color: "757D75", size:9},
							{content:"Q" + '%.2f' % debe, align: :right, borders: [:left, :right], border_width: 1, border_color: "757D75", size:10},
							{content:"Q" + '%.2f' % haber, align: :right, borders: [:left, :right], border_width: 1, border_color: "757D75", size:10},
							{content:saldo_deudor, align: :right, borders: [:left, :right], border_width: 1, border_color: "757D75", size:10},
							{content:saldo_acreedor, align: :right, borders: [:left, :right], border_width: 1, border_color: "757D75", size:10} 
						]
					]
					header += cuenta
				end
			end

			if header.length <= 2
				header += [["Totales", "0.00", "0.00", "0.00", "0.00"]]
			else
				header += [
					[
						{content:"Totales", font_style: :bold, align: :right}, 
						{content:"Q" + '%.2f' % total_debe, align: :right, border_color: "000000", border_bottom_width: 2, border_top_width: 2, size:10}, 
						{content:"Q" + '%.2f' % total_haber, align: :right, border_color: "000000", border_bottom_width: 2, border_top_width: 2, size:10}, 
						{content:"Q" + '%.2f' % total_deudor, align: :right, border_color: "000000", border_bottom_width: 2, border_top_width: 2, size:10}, 
						{content:"Q" + '%.2f' % total_acreedor, align: :right, border_color: "000000", border_bottom_width: 2, border_top_width: 2, size:10}
					]
				]
			end

			table( header, header: true, width: 540)

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
				"No es un periodo valido"
			end
		end
	end