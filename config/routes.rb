# config/routes.rb

Rails.application.routes.draw do
  # Devise for customers
  devise_for :customers, controllers: { sessions: 'customers/sessions' }

  # ActiveAdmin for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Resources
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

  # Routes related to products
  get 'result/:id', to: 'products#show', as: 'result'
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  get 'products/add_to_cart/:id', to: 'products#add_to_cart' # Because of bugs
  get 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart' # Because of bugs

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Search route
  get '/search', to: 'search#index', as: 'search'

  # Root route
  root 'about#index'

  # Stripe-related routes
  scope '/checkout' do
    post '/create', to: 'checkout#create', as: "checkout_create"
    get '/create', to: 'checkout#create', as: 'checkout_create2'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end
end
