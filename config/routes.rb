Rails.application.routes.draw do

  root 'products#index'

  devise_for :users
  resources :orders
  resources :products, only: [:index, :show]
end
