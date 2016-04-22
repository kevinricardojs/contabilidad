class ComprasPdf < Pdf

	def initialize(iva, base, compras_por_dia, total, total_cuentas, u, compras_por_cuenta,folio)
		super("Libro de Compras y Servicios Recibidos", u, 0, 100, "current", "portrait")
		@compras_por_cuenta = compras_por_cuenta
		@compras_por_dia = compras_por_dia
		@iva = iva
		@base = base
		@total = total
		grid([1, 0], [9,11]).bounding_box do
			compras
			@puntero  = cursor.to_s
		end
		cuentas_per_nombre(@puntero)
		enumerar_paginas("portrait")
	end

	def compras
		title = [
			[
				{ content: "", colspan: 4, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "Proveedor", colspan:2, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "Base Gravada", colspan: 2, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "Base Exenta", colspan: 2, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "", colspan: 3, borders: [:top, :right, :left], font_style: :bold, align: :center }
			],
			[
				{ content: "Dia", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 } ,	
				{ content: "Tipo", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Serie", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Numero", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Nit", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Nombre", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Bienes", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Servicios", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Bienes", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Servicios", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Base", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Iva", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 },
				{ content: "Total", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:7 }
			]
		]


		@compras_por_dia.each do |compra|
			dato = [
				[
					{content:compra.dia.to_s, size: 8 , align: :center, borders: [:left, :right]},
					{content:compra.documento.to_s, size: 8, align: :center, borders: [:left, :right] },
					{content:compra.serie.to_s, size: 8, align: :center, borders: [:left, :right] },
					{content:compra.numero.to_s, size: 8 , align: :center, borders: [:left, :right]},
					{content:compra.proveedor.nit.to_s, size: 8 , align: :center, borders: [:left, :right]},
					{content:compra.proveedor.nombre, size: 8, align: :center, borders: [:left, :right] },
					{content:compra.gravado_bienes.to_s, size: 8, align: :right, borders: [:left, :right] },
					{content:compra.gravado_servicios.to_s, size: 8 , align: :right, borders: [:left, :right]},
					{content:compra.exento_bienes.to_s, size: 8, align: :right, borders: [:left, :right] },
					{content:compra.exento_servicios.to_s, size: 8 , align: :right, borders: [:left, :right]},
					{content: "Q" + '%.2f' % compra.base.to_f, size: 7 , align: :right, borders: [:left, :right]},
					{content: "Q" + '%.2f' % compra.iva.to_f, size: 7 , align: :right, borders: [:left, :right]},
					{content: "Q" + '%.2f' % compra.total.to_f, size: 7, align: :right , borders: [:left, :right]}
				]
			]
			title += dato
		end
		title += [[ {content: "", colspan: 13, borders: [:top]}]]
		table( title, header: true, width: 523, cell_style:{ border_color: "333333", text_color: "333333"})
	end

	def cuentas_per_nombre(puntero)
		@p = puntero.to_i - 10
		title_cuenta = [
			[{ content: "Resumen por Cuenta Contable", colspan: 13, size: 10, font_style: :bold, align: :center}],[ {content: "Nombre", colspan: 9, size: 10, font_style: :bold, align: :center}, { content: "Suma de Base", colspan:4, size: 10, font_style: :bold, align: :center}]
		]

		@compras_por_cuenta.each do |cuenta| 
			data = [ [ {content: cuenta[0].to_s, colspan: 9, size: 8, borders: [:left, :right]}, {content: "Q" + '%.2f' % cuenta[1], colspan: 4, size: 8, align: :right, borders: [:left, :right]}]]
			title_cuenta += data
		end
		title_cuenta += [[ {content: "Iva", colspan: 9, size: 8, borders: [:left, :right]}, {content: "Q" + '%.2f' % @iva, colspan: 4, size: 8, align: :right, borders: [:left, :right]}], [{content: "Total", colspan: 9, size: 8}, {content: "Q" + '%.2f' % @total, colspan: 4, size: 8, align: :right}]]
		bounding_box([0, @p], width: 523) do
			table(title_cuenta, header: true, width: 523, cell_style:{ border_color: "333333", text_color: "333333"} )
		end

	end
end