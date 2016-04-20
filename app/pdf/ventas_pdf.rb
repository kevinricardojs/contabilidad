class VentasPdf < Pdf
	def initialize(iva, base, bienes, servicios, total, ventas_c, u)
		super("Libro de Ventas", u, 1, 10, "current", "portrait")
		@iva = iva
		@base = base
		@bienes = bienes
		@servicios = servicios
		@total = total
		@ventas = ventas_c
		grid([1, 0], [11,9]).bounding_box do
			ventas
			@puntero  = cursor.to_s
		end
		resumen(@puntero)
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
				movimiento =[
					[
						{content:venta["dia"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["documento"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["nit"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["min"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["max"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["serie"].to_s, size: 10, borders: [:left, :right], align: :center },
						{content:venta["nombre"].to_s, size: 9, borders: [:left, :right], align: :center, width: 150 },
						{content:"Q" + '%.2f' % venta["gravado_bienes"].to_f, size: 10, borders: [:left, :right], align: :right },
						{content:"Q" + '%.2f' % venta["gravado_servicios"].to_f, size: 10, borders: [:left, :right], align: :right }
					]
				]

				title += movimiento
				title += [[{content: "", colspan:9, borders: [:top]}]]
			end

			table(title, header: true, width: 540)
		end

		def resumen(puntero)
			@p = puntero.to_i - 10
			tabla = [
				[{content:"Resumen", colspan:2,align: :center, font_style: :bold}],
				[{content:"Bienes", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @bienes.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content:"Servicios", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @servicios.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content:"IVA", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @iva.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content:"Total", size: 10, borders: [:left, :right]}, {content:"Q" + '%.2f' % @total.to_f, align: :right, size: 10, borders: [:left, :right]}],
				[{content: "", colspan:2, borders: [:top]}]
			]
			bounding_box([0, @p], width: 540) do
				table(tabla, header: true, width: 540)
			end

		end

	end