Rails.application.routes.draw do
  
  devise_for :admins
  resources :users, only: [:index, :show]
  resources :stages, only: [:new, :create, :index, :show]
end
