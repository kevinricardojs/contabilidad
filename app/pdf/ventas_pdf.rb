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
						{content:venta["dia"].to_s, size: 10, borders: [:left, :right] },
						{content:venta["documento"].to_s, size: 10, borders: [:left, :right] },
						{content:venta["nit"].to_s, size: 10, borders: [:left, :right] },
						{content:venta["min"].to_s, size: 10, borders: [:left, :right] },
						{content:venta["max"].to_s, size: 10, borders: [:left, :right] },
						{content:venta["serie"].to_s, size: 10, borders: [:left, :right] },
						{content:venta["nombre"].to_s, size: 10, borders: [:left, :right] },
						{content:"Q" + '%.2f' % venta["gravado_bienes"].to_f, size: 10, borders: [:left, :right] },
						{content:"Q" + '%.2f' % venta["gravado_servicios"].to_f, size: 10, borders: [:left, :right] }
					]
				]

				title += movimiento
				title += [[{content: "", colspan:9, borders: [:top]}]]
			end

			table(title, header: true, width: 540)
		end

	end