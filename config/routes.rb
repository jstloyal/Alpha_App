Rails.application.routes.draw do
  # root to: 'articles#index'
  root "articles#new"
  resources :articles
end
