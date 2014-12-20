Rails.application.routes.draw do

    # === STORE ===
    get 'store/index'
    get 'store/products/:id', to: 'store#products'


  resources :products
end
