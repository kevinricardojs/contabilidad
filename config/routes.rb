Rails.application.routes.draw do

  get 'libro/mayor'
  get 'libro/balance_primer_periodo'
  get 'libro/balance_segundo_periodo'
  get 'libro/balance_tercer_periodo'
  get 'libro/balance_cuarto_periodo'

  resources :partidas, except:[:index, :show, :new]

  get 'libro_diario/partidas'
  get 'libro_diario/resumen'

  resources :tipo_de_gastos

  resources :venta_libros, path: "libro_de_ventas", except:[:index]
  resources :compra_libros, path: "libro_de_compras", except:[:index]
  get 'compra_libros/destroy_all'
  devise_for :usuarios, controllers: {registrations: "registrations"}
  resources :proveedors
  resources :establecimientos do
    resources :folios
  end
  resources :contribuyentes
  get 'inicio/index'
  post 'peticion_json/contribuyentes'
  post 'peticion_json/establecimientos'
  post 'peticion_json/proveedores'
  post 'peticion_json/tipos_de_gastos'
  get 'operaciones/libro_venta'
  get 'operaciones/libro_compra'

  root 'inicio#index'

end
