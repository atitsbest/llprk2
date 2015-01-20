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
    get 'order/express' # PayPal Express Setup.
    get 'order/express_create/:id', to: 'order#express_create', as: 'order_create_express' # PayPal Express Return Url (ersellt die Bestellung).


    resources :products

    root 'store#index'
end
