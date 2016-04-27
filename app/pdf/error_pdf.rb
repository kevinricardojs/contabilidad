class ErrorPdf < Prawn::Document
	def initialize
		super()

		mostrar_error()
	end

	def mostrar_error
		define_grid(columns: 12, rows:10)
		grid([1,1],[3,10]).bounding_box do
			float do
				fill_color 'F2838F'
				fill_rectangle [0, bounds.height], bounds.width, bounds.height
				fill_color '000000'
			end
			move_down 80
			text "X", align: :center, size: 30
			text "Lamentablemente no has registrado este Folio para trabajarlo", align: :center, color: 'A94442' , style: :bold
			text "Debes ir al los Folios de este establecimiento para poder registrarlo", align: :center, color: 'A94442'

			fill_color "DA4453"
			stroke_color "DA4453"
			fill_and_stroke_circle [225, 150], 40
			fill_color "FFFFFF"
			stroke_color "FFFFFF"
			fill_and_stroke_rectangle [220, 175], 10, 30
			fill_and_stroke_rectangle [220, 140], 10, 10
		end

	end
end