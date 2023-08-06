Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      resources :users, only: [:show]
      resources :stages, only: [:show]
    end
  end
  resources :users, only: [:index, :show]
  resources :stages, only: [:new, :create, :index, :show, :edit, :update]
end
