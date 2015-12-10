json.array!(@venta_libros) do |venta_libro|
  json.extract! venta_libro, :id, :documento, :serie, :numero, :dia, :mes, :year, :nit, :nombre, :gravado_bienes, :gravado_servicios, :exento_bienes, :exento_servicios, :base, :iva, :total, :contribuyente_id, :establecimiento_id
  json.url venta_libro_url(venta_libro, format: :json)
end
