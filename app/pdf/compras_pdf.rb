class ComprasPdf < Pdf

	def initialize(iva, base, compras_por_dia, total, total_cuentas, u, compras_por_cuenta, folio, periodo)
		super("Libro de Compras y Servicios Recibidos", u, folio, periodo, "portrait")
		@compras_por_cuenta = compras_por_cuenta
		@compras_por_dia = compras_por_dia
		#text @compras_por_dia.to_a.to_s
		@iva = iva
		@base = base
		@total = total
		grid([1, 0], [9,11]).bounding_box do
			compras
			@puntero  = cursor.to_s
			cuentas_per_nombre
		end

		enumerar_paginas("portrait")
	end

	def compras
		title = [
			[
				{ content: "", colspan: 4, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "Proveedor", colspan:2, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "Gravado", colspan: 2, borders: [:top, :right, :left], font_style: :bold, align: :center },
				{ content: "", colspan: 4, borders: [:top, :right, :left], font_style: :bold, align: :center }
				],
				[
					{ content: "Dia", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 } ,
					{ content: "Tipo", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Serie", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Numero", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Nit", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Nombre", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Bienes", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Servicios", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:8 },
					{ content: "Base", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Iva", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 },
					{ content: "Total", borders: [:bottom, :right, :left], font_style: :bold, align: :center, size:9 }
				]
			]


			@compras_por_dia.each do |compra|
				dato = [
					[
						{content: compra.dia.to_s, size: 6 , align: :center, borders: [:left, :right]},
						{content: compra.documento.to_s, size: 6, align: :center, borders: [:left, :right] },
						{content: compra.serie.to_s, size: 6, align: :center, borders: [:left, :right] },
						{content: compra.numero.to_s, size: 6 , align: :center, borders: [:left, :right]},
						{content: compra.proveedor.nit.to_s, size: 6 , align: :center, borders: [:left, :right]},
						{content: compra.proveedor.nombre.to_s, size: 6, align: :center, borders: [:left, :right] },
						{content: compra.bienes.to_f.to_s, size: 6, align: :right, borders: [:left, :right] },
						{content: compra.servicios.to_f.to_s, size: 6 , align: :right, borders: [:left, :right]},
						{content: "Q" + '%.2f' % compra.base.to_s, size: 6 , align: :right, borders: [:left, :right]},
						{content: "Q" + '%.2f' % compra.iva.to_s, size: 6 , align: :right, borders: [:left, :right]},
						{content: "Q" + '%.2f' % compra.total.to_s, size: 6, align: :right , borders: [:left, :right]}
					]
				]
				title += dato
			end
			title += [[ {content: "",width: 523, colspan: 11, borders: [:top]}]]
			table( title, header: true, cell_style:{ border_color: "333333", text_color: "333333"} )
	end

	def cuentas_per_nombre
			title_cuenta = [
				[{ content: "Resumen por Cuenta Contable", colspan: 13, size: 10, font_style: :bold, align: :center}],[ {content: "Nombre", colspan: 9, size: 10, font_style: :bold, align: :center}, { content: "Suma de Base", colspan:4, size: 10, font_style: :bold, align: :center}]
			]

			@compras_por_cuenta.each do |cuenta|
				data = [ [ {content: cuenta[0].to_s, colspan: 9, size: 8, borders: [:left, :right]}, {content: "Q" + '%.2f' % cuenta[1], colspan: 4, size: 8, align: :right, borders: [:left, :right]}]]
				title_cuenta += data
			end
			title_cuenta += [[ {content: "Iva", colspan: 9, size: 8, borders: [:left, :right]}, {content: "Q" + '%.2f' % @iva, colspan: 4, size: 8, align: :right, borders: [:left, :right]}], [{content: "Total", colspan: 9, size: 8}, {content: "Q" + '%.2f' % @total, colspan: 4, size: 8, align: :right}]]
			table(title_cuenta, header: true, width: 523, cell_style:{ border_color: "333333", text_color: "333333"} )
	end
end
