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

root 'about#index'

get '/search', to: 'search#index', as: 'search'

end
