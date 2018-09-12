Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/dashboard', to: 'dashboard#index'
  get '/conditions-dashboard', to: 'conditions_dashboard#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :stations, only: [:index, :show], param: :slug

  resources :trips, only: [:index, :show]

  resources :conditions, only: [:index, :show]

  resources :carts, only: [:create, :index]

  resources :users, only: [:new, :create]

  resources :orders, only: [:create, :show]

  get '/bike-shop', to: 'items#index'
  resources :items, only: [:show]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :trips, only: [:edit, :destroy, :new, :create, :update]
    resources :conditions, only: [:edit, :destroy, :new, :create, :update]
    resources :stations, only: [:edit, :update, :destroy]
  end


end
