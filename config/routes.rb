Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :test, only: %i[index]

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: %i[index]
      end

      resources :users, only: %i[show], param: :user_name

      resources :stages, only: %i[new index create show edit update] do
        resource :user_stage_progresses, only: %i[create destroy]
      end
    end
  end

  resources :stages, only: %i[new index create show edit update]
  resources :users, only: %i[index show]
  root to: "stages#index"
end
