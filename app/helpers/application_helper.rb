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
end
