module ApplicationHelper

  def helper_establecimiento_nombre
    if @u.establecimiento_id
      @u.establecimiento.nombre
    else
      "Selecciona Establecimiento"
    end
  end

  def helper_contribuyente_nombre
    if @u.contribuyente_id
      @u.contribuyente.nombre
    else
      "Selecciona Contribuyente"
    end
  end

  def helper_contribuyente_nit
    if @u.contribuyente_id
      @u.contribuyente.nit
    else
      "Selecciona Contribuyente"
    end
  end

  def print_meses_periodo(periodo)
    case periodo
    when 1
      "Enero, Febrero, Marzo del  #{@u.year}"
    when 2
      "Abril, Mayo, Junio del  #{@u.year}"
    when 3
      "Julio, Agosto, Septiembre del  #{@u.year}"
    when 4
      "Octubre, Noviembre, Diciembre del  #{@u.year}"
    else
      "No es un periodo valido"
    end
  end
end
