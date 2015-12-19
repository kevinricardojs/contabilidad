Rails.application.routes.draw do

  

  resources :venta_libros
  resources :compra_libros
  devise_for :usuarios, controllers: {registrations: "registrations"}
  resources :cuenta_contables
  resources :proveedors
  resources :establecimientos
  get 'inicio/index'
  get 'inicio/operacion'
  get 'operaciones/libro_venta'
  get 'operaciones/libro_compra'
  resources :contribuyentes

  root 'inicio#index'

end
