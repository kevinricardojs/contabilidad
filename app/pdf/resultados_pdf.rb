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
end

def body

grid([1,0],[9,11]).bounding_box do
tabla = []

pollo = [
[
{content: "Ingresos",font_style: :bold, align: :center, size: 11, colspan: 3}
],
[
{content: "Ventas", align: :left, borders: [:top, :left, :right]},
{content: "", borders:[:left]},
{content: to_money(ventas_bienes.to_s), align: :right, size: 10, borders: [:right]}
],
[
{content: "Costo de Ventas",font_style: :bold,align: :center, size: 11, colspan: 3}
],
[
{content: "Compras", align: :left, borders: [:top, :left, :right]},
{content: to_money(total_compras.to_s), align: :right, size: 10, borders: [:left]},
{content: "", borders:[:right]}
],
[
{content: "Fletes Sobre Compras", align: :left, borders: [:left, :right]},
{content: to_money(fletes_sobre_compras), align: :right, size: 10, borders: [:left]},
{content: "", borders:[:right]}
],
[
{content: "Inventario Inicial", align: :left, borders: [:left, :right]},
{content: to_money(inventario_inicial), align: :right, size: 10, borders: [:left]},
{content: "", borders:[:right]}
],
[
{content: "Disponibilidad", font_style: :bold, align: :center, borders: [:left, :right]},
{content: to_money(disponibilidad), align: :right, size: 10, borders: [:left, :top]},
{content: "", borders:[:right]}
],
[
{content: "Inventario Final", align: :left, borders: [:left, :right]},
{content: "", align: :right, size: 10, borders: [:left]},
{content: to_money(inventario_final),align: :right, size: 10, borders:[:right]}
],
[
{content: ganancia_perdida + " bruta en Ventas", font_style: :bold, align: :center, borders: [:left, :right]},
{content: "", borders:[:left, :top]},
{content: to_money(ganancia_perdida_bruta), align: :right, size: 10, borders: [:right, :top]}
],
[
{content: "Servicios Prestados", align: :left, borders: [:left, :right]},
{content: "",  align: :right, borders: [:left]},
{content: to_money(ventas_servicios), size: 10, align: :right, borders: [:right]}
],
[
{content: "Gastos de Operacion",font_style: :bold, align: :center, size: 11, colspan: 3}
],

]

tabla +=  pollo
table(tabla, width: 523) do
columns(0).width = 303
columns(1).width = 100
columns(2).width = 100
end
end

end

  def ventas_bienes
    ventas_bienes = 0
  #Suma de Todas las ventas del lado de Bienes
    @balance.establecimiento.libro_vs.each do |libro|
      ventas_bienes += libro.venta_libros.sum(:bienes)
    end
    return ventas_bienes
  end

  def total_compras
    bienes = 0
    servicios = 0
    @balance.establecimiento.libro_cs.each do |libro|
      bienes += libro.compra_libros.sum(:bienes)
    end
    @balance.establecimiento.libro_cs.each do |libro|
      servicios += libro.compra_libros.sum(:servicios)
    end
    total = bienes + servicios
  end

  def fletes_sobre_compras
    suma = @balance.cuentas.where(nombre_: "fletes_sobre_compras").sum(:debe)
    if suma == "0"
      return "Añade esta cuenta en una partida"
    else
      return suma.to_s
    end
  end

  def inventario_inicial
    "Aca va el Inventario Inicial"
  end

  def inventario_final
    disponibilidad
  end

  def disponibilidad
    return (total_compras.to_f + fletes_sobre_compras.to_f + inventario_inicial.to_f).to_s
  end

  def ganancia_perdida
    if ganancia_perdida_bruta.to_f >= 0
      "Ganancia"
    else
      "Perdida"
    end
  end

  def ganancia_perdida_bruta
    ventas_bienes.to_f - inventario_final.to_f
  end

  def ventas_servicios
    ventas_servicios= 0
  #Suma de Todas las ventas del lado de Bienes
  @balance.establecimiento.libro_vs.each do |libro|
    ventas_servicios += libro.venta_libros.sum(:servicios)
  end
  return ventas_servicios
  end


  def to_money(cantidad)
    if cantidad.to_f != 0.0
      "Q" + '%.2f' % (cantidad.to_f)
    else
      cantidad
    end
  end

end
