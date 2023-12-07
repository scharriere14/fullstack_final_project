Rails.application.routes.draw do
  get 'search/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :addresses
  resources :customers
  resources :orders

  get 'result/:id', to: 'products#show', as: 'result'
  resources :products do
    collection do
      get 'search'
    end
  end
get "up" => "rails/health#show", as: :rails_health_check
get '/search', to: 'search#index', as: 'search'
root 'about#index'

post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
get 'products/add_to_cart/:id', to: 'products#add_to_cart' # Because of bugs
delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

end
