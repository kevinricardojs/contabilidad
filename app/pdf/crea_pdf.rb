class CreaPdf < Prawn::Document
	def initialize(coleccion, u, folios_consumidos, folios_max)
		super()
		define_grid(columns: 10, rows:12)
		@cuentas = @cuentas = Cuenta.all.group(:nombre_).count
		@u = u
		@folios_consumidos = folios_consumidos.to_i
		@folios_max = folios_max.to_i
		@coleccion = coleccion
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
			text_box @u.contribuyente.nombre , size: 14, style: :bold, height: 16, width: 300, at:[0, 720]
			text_box "Fecha: #{dia}" ,height: 16, width: 150, at:[400, 720], size:12, style: :normal
			text_box @u.establecimiento.nombre, size: 14, style: :bold, height: 16, width: 400, at:[0, 704]
			text_box "Hora: #{hora}" , height: 16, width: 150, at:[400, 704], size:12, style: :normal
			text_box "Nit: #{@u.contribuyente.nit}", size: 14, style: :bold, height: 16, width: 400, at:[0, 688]
			text_box "Periodo:", size: 10, style: :bold, height: 16, width: 200, at:[0, 672]
			text_box "Balance General de Cuentas", size: 14, style: :bold, height: 16, width: 200, at:[180, 672]
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
			
			header = [ [{content: "", colspan: 1}, {content: "Saldos", colspan: 2, align: :center, font_style: :bold}, {content: "Totales", colspan: 2, align: :center, font_style: :bold} ], [{content:"Cuentas", align: :center, font_style: :bold}, {content:"Debe", align: :center, font_style: :bold}, {content:"Haber", align: :center, font_style: :bold},{content:"Debe", align: :center, font_style: :bold}, {content:"Haber", align: :center, font_style: :bold}]]
			cuentas = []
			total_deudor = 0 
			total_acreedor = 0
			total_debe = 0
			total_haber = 0
			@cuentas.each do |cuenta|
				nombre = Cuenta.where(nombre_: cuenta[0] ).first.nombre
				debe = Cuenta.where(nombre_: cuenta[0] , balance_id: @coleccion.id).sum(:debe).to_f
				haber = Cuenta.where(nombre_: cuenta[0] , balance_id: @coleccion.id).sum(:haber).to_f
				total_debe += debe
				total_haber += haber

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
				cuenta = [[ {content:nombre, align: :left} , {content:"Q" + '%.2f' % debe, align: :right} , {content:"Q" + '%.2f' % haber, align: :right} , {content:saldo_deudor, align: :right} , {content:saldo_acreedor, align: :right} ]]
				header += cuenta
			end

			header += [[{content:"Totales", font_style: :bold, align: :right}, {content:"Q" + '%2.f' % total_debe, align: :right}, {content:"Q" + '%2.f' % total_haber, align: :right}, {content:"Q" + '%2.f' % total_deudor, align: :right}, {content:"Q" + '%2.f' % total_acreedor, align: :right}]]
			table(header, header:true)
		end


	end