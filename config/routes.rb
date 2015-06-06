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

    # === ADMIN ===
    namespace :admin do
        resources :sessions, only: [:new, :create, :destroy]
        get 'dashboard', to: 'dashboard#index', as: 'dashboard'
        get '', to: 'dashboard#index'
    end

    root 'store#index'
end
