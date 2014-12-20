Rails.application.routes.draw do

    # === STORE ===
    get 'store/index'
    get 'store/products/:id', to: 'store#products', as: 'store_products'

    # === LINEITEMS ===
    post 'line_items', to: 'line_items#create'

    # === CART ===
    get 'cart/show', to: 'cart#show', as: 'cart'


    resources :products
end
