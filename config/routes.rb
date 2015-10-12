Rails.application.routes.draw do
  get 'dashboards/index'

  get 'static_pages/about'
  get 'static_pages/home'
  get 'static_pages/help'

#  resources :users, only: [:index, :show, :new, :edit, :create, :update]
  resources :users, only: [:new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :companies, only: [:index]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  get '/companies/:company_id/stations' => 'stations#index', as: 'station_index'
  get '/companies/:company_id/rosens' => 'rosens#index', as: 'rosen_index'

  get '/stations/:station_id' => 'stations#show', as: 'station_detail'
  get '/rosens/:rosen_id' => 'rosens#show', as: 'rosen_detail'

#  get '/user/:name' => 'users#show'

  root 'dashboards#index'
end
