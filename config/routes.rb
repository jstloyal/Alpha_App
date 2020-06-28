Rails.application.routes.draw do
 
  root 'articles#home'
  resources :articles
  resources :user
end
