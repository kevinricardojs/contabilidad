json.array!(@empresas) do |empresa|
  json.extract! empresa, :id, :nombre, :direccion, :zona, :nit, :telefono
  json.url empresa_url(empresa, format: :json)
end
