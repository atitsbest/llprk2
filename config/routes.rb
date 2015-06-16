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

    # === ADMIN ===
    namespace :admin do
        resources :sessions, only: [:new, :create] do
            get "destroy", on: :member, :as => "logout"
        end
        get 'dashboard', to: 'dashboard#index', as: 'dashboard'
        get '', to: 'dashboard#index'
        resources :products
    end

    root 'store#index'
end
