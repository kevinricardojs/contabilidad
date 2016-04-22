class PartidasPdf < Pdf
	def initialize(partidas, u)
		super("Resumen de Partidas del Libro Diario", u, 1, 100, u.mes, "portrait")
		@partidas_libro_diario = partidas

		grid([1, 0], [9,11]).bounding_box do
			partidas_render
		end
		enumerar_paginas("portrait")
	end

	def partidas_render

		titulo = [
			[
				{content:"Nombre de Cuentas",  font_style: :bold, align: :center},
				{content:"Debe",  font_style: :bold, align: :center},
				{content:"Haber",  font_style: :bold, align: :center}
			]
		]

		@partidas_libro_diario.each do |p| 			
			numero = p.numero_partida.to_s
			total_debe = "Q" + '%.2f' % p.total["debe"] 
			total_haber = "Q" + '%.2f' % p.total["haber"] 
			descripcion = p.descripcion
			partida = [
				[
					{content:"Partida #" + numero, colspan: 3, font_style: :bold, align: :center }
				]
			]
			p.cuentas.order(:posicion).each do |cuenta| 
				nombre = cuenta.nombre
				debe ="Q" + '%.2f' % cuenta.debe if  cuenta.debe != "" &&  cuenta.debe != "0.0"  
				haber ="Q" + '%.2f' % cuenta.haber if cuenta.haber != "" && cuenta.haber != "0.0" 
				dato = [
					[
						{content: nombre.to_s, borders: [:right,:left]},
						{content:debe.to_s, align: :right, borders: [:right]},
						{content:haber.to_s, align: :right, borders: [:right]}
					]
				]
				partida += dato
			end 

			partida += [ [{content:"Totales"}, {content:total_debe, align: :right, border_top_width: 1, border_lines: [:dashed, :solid, :solid, :solid]}, {content:total_haber, align: :right, border_top_width: 1, border_lines: [:dashed, :solid, :solid, :solid]}], [ {content:"Descripcion"}, {content:descripcion, colspan: 2, align: :center, size: 10}]]
			titulo += partida
		end
		
		table(titulo, header: true, width: 523, cell_style:{ border_color: "333333", font_color: "333333"} )
	end
end