Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create]
  resources :orders, only: [:index, :new, :create, :show]
end
