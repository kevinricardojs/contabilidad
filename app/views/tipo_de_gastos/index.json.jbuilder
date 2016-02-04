json.array!(@tipo_de_gastos) do |tipo_de_gasto|
  json.extract! tipo_de_gasto, :id, :nombre
  json.url tipo_de_gasto_url(tipo_de_gasto, format: :json)
end
