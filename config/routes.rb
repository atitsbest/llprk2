Rails.application.routes.draw do


    # === STORE ===
    get 'store/index', as: 'store'
    get 'store/products/:id', to: 'store#products', as: 'store_products'

    # === LINEITEMS ===
    post 'line_items', to: 'line_items#create'

    # === CART ===
    get 'cart/show', to: 'cart#show', as: 'cart'

    # === ORDER ===
    get 'order/index', as: 'orders'
    get 'order/new'
    get 'order/create'


    resources :products

    root 'store#index'
end
