Rails.application.routes.draw do
  get 'companies/new'

  get 'static_pages/about'

  get 'static_pages/home'

  get 'static_pages/help'

  resources :users, only: [:index, :show, :new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  root 'users#index'

end
