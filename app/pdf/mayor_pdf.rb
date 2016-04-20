class MayorPdf < Pdf
	def initialize(tipo, libro, u, folios_consumidos, folios_max, periodo, orientation)
		super(tipo, u, folios_consumidos, folios_max, periodo, orientation)
		@u = u
		define_grid(columns: 12, rows:10)
		@libro_diario = libro
		grid([1, 0], [11,5]).bounding_box do
			debe
		end
		grid([1, 6], [11,9]).bounding_box do
			haber
		end
		@cuentas = Cuenta.all.group(:nombre_).count
	end

	def debe
		partidas = [ 
			[{content:"Debe", align: :center, font_style: :bold, border_color: "757D75", colspan:5}],
			[
				{content:"Mes", align: :center, font_style: :bold, border_color: "757D75", size: 10},
				{content:"Dia", align: :center, font_style: :bold, border_color: "757D75", size: 10}, 
				{content:"Descripción", align: :center, font_style: :bold, border_color: "757D75"},
				{content:"", colspan:2, align: :center, font_style: :bold, border_color: "757D75"}
			]
		]
		@cuentas.each do |nombre|
			suma = @libro_diario.cuentas.where(nombre_: nombre).sum(:debe)  
			if suma != "" && suma != "0" && suma != "0.0" && suma != "0.00"
				name = Cuenta.find_by(nombre_: nombre[0]).nombre
				partida = [[{content: name, colspan:5, align: :center, font_style: :bold, border_bottom_color: "AAAAAA"}]]
				cuentas = LibroDiario.find(@libro_diario).cuentas.where(nombre_: nombre)
				cuentas.each do |cuenta|
					if cuenta.debe != "" && cuenta.debe != "0" && cuenta.debe != "0.0" && cuenta.debe != "0.00"
						partida.push [ {content:@u.mes, size: 8, borders:[:left]} , {content: cuenta.partida.dia, size: 8, align: :center, borders:[]}, {content: cuenta.partida.descripcion, size: 9, borders:[], width: 200}, {content: "Q" + '%.2f' % cuenta.debe.to_f, size: 8, align: :right, borders:[]} , {content: "----", borders:[:right], align: :center}]
					end
				end
				partida.push [{content: "", colspan: 4, border_top_color: "AAAAAA"}, {content: "Q" + '%.2f' % suma, size: 10, align: :right}]
				partidas += partida
			end
		end
		if partidas.length <= 1
			partidas += [[@u.mes, "", "", "", ""]]
		end
		table( partidas, header: true, width: 384)
	end

	def haber
		partidas = [ 
			[{content:"Haber", align: :center, font_style: :bold, border_color: "757D75", colspan:5}],
			[
				{content:"Mes", align: :center, font_style: :bold, border_color: "757D75", size: 10},
				{content:"Dia", align: :center, font_style: :bold, border_color: "757D75", size: 10}, 
				{content:"Descripción", align: :center, font_style: :bold, border_color: "757D75"},
				{content:"", colspan:2, align: :center, font_style: :bold, border_color: "757D75"}
			]
		]
		@cuentas.each do |nombre|
			suma = @libro_diario.cuentas.where(nombre_: nombre).sum(:haber)
			if suma != "" && suma != "0" && suma != "0.0" && suma != "0.00"
				name = Cuenta.find_by(nombre_: nombre[0]).nombre
				partida = [[{content: name, colspan:5, align: :center, font_style: :bold, border_bottom_color: "FAFAFA"}]]
				cuentas = LibroDiario.find(@libro_diario).cuentas.where(nombre_: nombre)
				cuentas.each do |cuenta|
					if cuenta.haber != "" && cuenta.haber != "0" && cuenta.haber != "0.0" && cuenta.haber != "0.00"
						partida.push [ {content:@u.mes, size: 8, borders:[:left]} , {content: cuenta.partida.dia, size: 8, align: :center, borders:[]}, {content: cuenta.partida.descripcion, size: 9, borders:[], width: 200}, {content: "Q" + '%.2f' % cuenta.haber.to_f, size: 8, align: :right, borders:[]} , {content: "----", borders:[:right], align: :center}]
					end
				end
				partida.push [{content: "", colspan: 4, border_top_color: "AAAAAA"}, {content: "Q" + '%.2f' % suma, size: 10, align: :right}]
				partidas += partida
			end
		end

		if partidas.length <= 1
			partidas += [[@u.mes, "", "", "", ""]]
		end
		table( partidas, header: true, width: 384)
	end

end