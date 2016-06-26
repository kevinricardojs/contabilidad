class VentasPdf < Pdf
	def initialize(iva, base, bienes, servicios, total, ventas_c, u, folio)
		super("Libro de Ventas", u, folio, "current", "portrait")
		@iva = iva
		@base = base
		@bienes = bienes
		@servicios = servicios
		@total = total
		@ventas = ventas_c
		@u = u
		grid([1, 0], [9,11]).bounding_box do
			ventas
			@puntero  = cursor.to_s
			resumen
		end

		enumerar_paginas("portrait")
	end

	def ventas
		title = [
			[
				{content:"", borders: [:left, :right, :top]},
				{content: "Documento", colspan: 5, align: :center, font_style: :bold, borders: [:top]},
				{content:"", colspan: 3, borders: [:left, :right, :top]}

				],

				[
					{content:"Dia", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Tipo", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Nit", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Del", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Al", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Serie", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Comprador", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Bienes Precio Neto", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]},
					{content:"Precio de Servicios", align: :center, size: 8, font_style: :bold, borders: [:left, :right, :bottom]}
				]
			]

			@ventas.each do |venta|
				bienes = 0
				servicios = 0
				if @u.contribuyente.t_contribuyente == "normal"
					bienes = venta["gravado_bienes"]
					servicios = venta["gravado_servicios"]
				else
					bienes = venta["exento_bienes"]
					servicios = venta["exento_servicios"]
				end
				movimiento =[
					[
						{content:venta["dia"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["documento"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["nit"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["min"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["max"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["serie"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["nombre"].to_s, size: 9, borders: [:left, :right], align: :center, width: 150 },
						{content:"Q" + '%.2f' % bienes.to_f, size: 10, borders: [:left, :right], align: :right },
						{content:"Q" + '%.2f' % servicios.to_f, size: 10, borders: [:left, :right], align: :right }
					]
				]

				title += movimiento

			end
			title += [[{content: "", colspan:9, borders: [:top]}]]
			table(title, header: 2, width: 523, cell_style:{ border_color: "333333", font_color: "333333"})
		end

		def resumen

			tabla = [
				[{content:"Resumen", colspan:2,align: :center, font_style: :bold}],
				[{content:"Ventas por Bienes", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @bienes.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content:"Servicios Prestados", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @servicios.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content:"IVA", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @iva.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content:"Total", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @total.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content: "", colspan:2, borders: [:top]}]
			]

			table(tabla, header: true, width: 523, cell_style:{ border_color: "333333", font_color: "333333"})


		end

	end
