json.array!(@compra_libros) do |compra_libro|
  json.extract! compra_libro, :id, :documento, :serie, :numero, :proveedor_id, :dia, :mes, :year
  json.url compra_libro_url(compra_libro, format: :json)
end
