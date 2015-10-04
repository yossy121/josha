Rails.application.routes.draw do
  get 'stations/index'

  get 'stations/show'

  get 'static_pages/about'

  get 'static_pages/home'

  get 'static_pages/help'

  resources :users, only: [:index, :show, :new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :companies, only: [:index]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  get '/companies/:company_id/stations' => 'stations#show'
  get '/user/:name' => 'users#show'

  root 'users#index'
end
