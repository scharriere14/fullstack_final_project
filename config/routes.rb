Rails.application.routes.draw do
  get 'search/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :addresses
  resources :customers
  resources :orders

  resources :products do
    collection do
      get 'search'
    end

    post 'add_to_cart', on: :member
    get 'remove_from_cart', on: :member
  end

  get 'result/:id', to: 'products#show', as: 'result'
  get "up" => "rails/health#show", as: :rails_health_check
  get '/search', to: 'search#index', as: 'search'
  root 'about#index'

  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  get 'products/add_to_cart/:id', to: 'products#add_to_cart' # Because of bugs
  get 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart' # Because of bugs

  # Stripe stuff
  scope '/checkout' do
    post '/create', to: 'checkout#create', as: "checkout_create"
    get '/create.:id', to: 'checkout#create', as: 'checkout_create2'

    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end
end
