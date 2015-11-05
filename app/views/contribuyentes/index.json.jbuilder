json.array!(@contribuyentes) do |contribuyente|
  json.extract! contribuyente, :id, :nit, :nombre, :calle, :no_casa, :apto_similar, :zona, :colonia, :departamento, :municipio, :telefono, :fax, :apto_postal, :email
  json.url contribuyente_url(contribuyente, format: :json)
end
