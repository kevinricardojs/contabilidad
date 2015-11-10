json.array!(@proveedors) do |proveedor|
  json.extract! proveedor, :id, :nombre, :nit
  json.url proveedor_url(proveedor, format: :json)
end
