json.array!(@cuenta_contables) do |cuenta_contable|
  json.extract! cuenta_contable, :id, :nombre, :tipo
  json.url cuenta_contable_url(cuenta_contable, format: :json)
end
