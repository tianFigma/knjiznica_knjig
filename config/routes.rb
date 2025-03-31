Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :categories
  root "books#index"
end
