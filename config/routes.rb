Rails.application.routes.draw do


    # === STORE ===
    get 'store', to: 'store#index', as: 'store'
    get 'store/products/:id', to: 'store#products', as: 'store_products'

    # === LINEITEMS ===
    resources :line_items, only: [:create, :destroy, :update]

    # === ORDER ===
    resource :order do
        get 'success', on: :member
    end

    # === CART ===
    resource :cart, only: [:show]

    # === PAYMENT ===
    get 'payment/success'
    get 'payment/cancel'

    # === PRODUCTS ===
    resources :products

    root 'store#index'
end
