Rails.application.routes.draw do

  get 'dashboards' => 'dashboards#show', as: 'dashboard'

  get 'static_pages/about'
  get 'static_pages/home'
  get 'static_pages/help'

  resources :states, only: [:index]
  resources :users, only: [:index, :show, :new, :edit, :create, :update]
#  resources :users, only: [:new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :companies, only: [:index]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  get '/states/:state_id/stations' => 'stations#stateindex', as: 'station_index_state'
  get '/states/:state_id/rosens' => 'rosens#stateindex', as: 'rosen_index_state'

  get '/companies/:company_id/stations' => 'stations#companyindex', as: 'station_index_company'
  get '/companies/:company_id/rosens' => 'rosens#companyindex', as: 'rosen_index_company'

  get '/stations/:station_id' => 'stations#show', as: 'station_detail'
  get '/rosens/:rosen_id' => 'rosens#show', as: 'rosen_detail'

  root 'dashboards#show'
end
