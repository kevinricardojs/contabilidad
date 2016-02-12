Rails.application.routes.draw do
  resources :libro_diarios, except: :index do
    resources :partidas  
  end
  get 'libro_diario/resumen'

  resources :tipo_de_gastos
  
  resources :venta_libros
  resources :compra_libros
  devise_for :usuarios, controllers: {registrations: "registrations"}
  resources :proveedors
  resources :establecimientos
  get 'inicio/index'
  post 'peticion_json/contribuyentes'
  post 'peticion_json/establecimientos'
  post 'peticion_json/proveedores'
  post 'peticion_json/tipos_de_gastos'
  get 'operaciones/libro_venta'
  get 'operaciones/libro_compra'
  resources :contribuyentes

  root 'inicio#index'

end
