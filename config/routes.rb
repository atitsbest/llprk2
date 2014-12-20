Rails.application.routes.draw do
  get 'store/index'

  resources :products
end
