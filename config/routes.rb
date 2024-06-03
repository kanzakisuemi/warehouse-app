Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :stock_product_destination, only: [:create]
  end
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create]
  resources :orders, only: [:index, :new, :create, :show, :edit, :update] do
    resources :order_items, only: [:new, :create]
    get 'search', on: :collection
    get 'my', on: :collection
    post 'in_progress', on: :member
    post 'delivered', on: :member
    post 'canceled', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:show, :index, :create]
    end
  end

end
