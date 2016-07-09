class ResultadosPdf < Prawn::Document
  def initialize(balance)
    Prawn::Font::AFM.hide_m17n_warning = true
    super(bottom_margin: 30, page_layout: :portrait, page_size: 'A4')
    define_grid(columns: 12, rows:10)
    #grid.show_all
    @balance = balance
    cabecera
    body
  end

  def cabecera
    repeat(:all) do
    grid([0,3],[0,8]).bounding_box do
      text "Estado de Resultados" , size: 11, style: :bold, color: "333333", align: :center
      text "Aca va el nombre de La Empresa", size: 11, style: :bold, color: "333333", align: :center
      text "Ejercicio Fiscal practicado del 01 de Enero de 'AÑO' al 31 de Diciembre del 'AÑO'", size: 11, style: :bold, color: "333333", align: :center
      text "(Cifra en Quetzales)", size: 9, style: :bold, color: "333333", align: :center
    end
  end

    def body
      grid([1,0 ],[9,11]).bounding_box do
        text "Ingresos", size: 11, style: :bold, color: "333333", align: :center


      end
    end
  end
end
