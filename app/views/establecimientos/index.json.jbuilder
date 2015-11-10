json.array!(@establecimientos) do |establecimiento|
  json.extract! establecimiento, :id, :nombre, :calle, :numero_casa, :apto_similar, :zona, :colonia, :departamento, :municipio, :telefono, :fax, :apto_postal, :contribuyente_id
  json.url establecimiento_url(establecimiento, format: :json)
end
