Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:index, :show, :new, :create]
  resources :categories, only: [:index, :show, :new, :create]
  root "books#index"
end
