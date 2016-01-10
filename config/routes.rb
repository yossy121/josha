Rails.application.routes.draw do

  get 'infos' => 'infos#index', as: 'infos_index'

  get 'infos/:info_id' => 'infos#show', as: 'infos_show'

  get 'dashboards' => 'dashboards#show', as: 'dashboard'

  get 'static_pages/about'
  get 'static_pages/home'
  get 'static_pages/help'

  resources :states, only: [:index]
  resources :users, only: [:index, :show, :new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :companies, only: [:index]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  get '/states/:state_id/stations' => 'stations#stateindex', as: 'station_index_state'
  get '/states/:state_id/rosens' => 'rosens#stateindex', as: 'rosen_index_state'

  get '/companies/categories/:category_id' => 'companies#show', as: 'companies_show'
  get '/companies/:company_id/stations' => 'stations#companyindex', as: 'station_index_company'
  get '/companies/:company_id/rosens' => 'rosens#companyindex', as: 'rosen_index_company'

  get '/stations/:station_id' => 'stations#show', as: 'station_detail'
  get '/stations/:station_id/edit' => 'user_station_statuses#edit', as: 'station_edit'
  patch '/stations/:station_id' => 'user_station_statuses#update', as: 'user_station_status'
  put '/stations/:station_id' => 'user_station_statuses#update'

  get '/rosens/:rosen_id' => 'rosens#show', as: 'rosen_detail'
  get '/rosens/:rosen_id/stations' => 'stations#rosenindex', as: 'station_index_rosen'

  get '/rosens/:rosen_id/edit' => 'user_section_statuses#edit', as: 'section_edit'
  patch '/rosens/:rosen_id' => 'user_section_statuses#update', as: 'user_section_status'
  put '/rosens/:rosen_id' => 'user_section_statuses#update'


  root 'dashboards#show'
end
