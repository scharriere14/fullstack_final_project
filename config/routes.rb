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
  get "up" =>
