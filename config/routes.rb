Rails.application.routes.draw do
  # mount_devise_token_auth_for 'User', at: 'auth'
  namespace "api" do
    namespace "v1" do
      resources :stages, only: [:show]
    end
  end
  resources :stages, only: [:new, :create, :index, :show, :edit, :update]
  root to: "stages#index"
end
