class BalancePdf < Pdf
	def initialize(tipo, balance, u, folio, periodo, orientation, mes)
		
		super(tipo,u, folio, periodo, orientation)
		@mes = mes
		@balance = balance
		grid([1, 0], [9,11]).bounding_box do
			cuentas
		end
		enumerar_paginas("portrait")
	end

	def cuentas

		header = [ [
			{content: "", colspan: 1, border_color:"757D75"},
			{content: "Saldos", colspan: 2, align: :center, font_style: :bold, border_color: "757D75"},
			],
			[
				{content:"Cuentas", align: :center, font_style: :bold, border_color: "757D75"},
				{content:"Debe", align: :center, font_style: :bold, border_color: "757D75"},
				{content:"Haber", align: :center, font_style: :bold, border_color: "757D75"}
			]
		]
		cuentas = []
		total_deudor = 0 
		total_acreedor = 0
		@cuentas.each do |cuenta|
			nombre = Cuenta.where(nombre_: cuenta[0] ).first.nombre

			debe = Balance.find(@balance).cuentas.where("mes <= ? AND nombre_ = ?", @mes, cuenta[0]).sum(:debe).to_f
			haber = Balance.find(@balance).cuentas.where("mes <= ? AND nombre_ = ?", @mes, cuenta[0]).sum(:haber).to_f
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
						{content:saldo_deudor, align: :right, borders: [:left, :right], border_width: 1, border_color: "757D75", size:10},
						{content:saldo_acreedor, align: :right, borders: [:left, :right], border_width: 1, border_color: "757D75", size:10} 
					]
				]
				header += cuenta
			end
		end

		if header.length <= 2
			header += [["Totales", "0.00", "0.00"]]
		else
			header += [
				[
					{content:"Totales", font_style: :bold, align: :right}, 
					{content:"Q" + '%.2f' % total_deudor, align: :right, border_color: "000000", border_bottom_width: 2, border_top_width: 2, size:10}, 
					{content:"Q" + '%.2f' % total_acreedor, align: :right, border_color: "000000", border_bottom_width: 2, border_top_width: 2, size:10}
				]
			]
		end

		table( header, header: true, width: 523, cell_style: { border_color: "333333", font_color: "333333"})

	end


end