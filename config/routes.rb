Rails.application.routes.draw do

  root 'pages#home'
  resources :pages

  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]
end
