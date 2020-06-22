Rails.application.routes.draw do
  # root to: 'articles#index'
  root "articles#index"
  resources :articles
end
