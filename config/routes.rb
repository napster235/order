Rails.application.routes.draw do
  devise_for :users

  resources :orders
  resources :flowers

  root to: "home#index"
end
