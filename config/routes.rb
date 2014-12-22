Rails.application.routes.draw do


    # === STORE ===
    get 'store', to: 'store#index', as: 'store'
    get 'store/products/:id', to: 'store#products', as: 'store_products'

    # === LINEITEMS ===
    post 'line_items', to: 'line_items#create'

    # === CART ===
    get 'cart', to: 'cart#show', as: 'cart'

    # === ORDER ===
    get 'order/new'
    post 'order/new', to: 'order#create'


    resources :products

    root 'store#index'
end
