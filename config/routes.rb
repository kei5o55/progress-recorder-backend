Rails.application.routes.draw do
  devise_for :users,
    path: "api/v1",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "api/v1/sessions",
      registrations: "api/v1/registrations"
    }

  namespace :api do
    namespace :v1 do
      get "health", to: "health#index"
      get "me", to: "users#me"
      get "test", to: "users#test"

      resources :projects, only: [ :index, :create ] do
        resources :commits, only: [ :index, :create ]
      end

      resources :work_sessions, only: [ :index, :create ]
    end
  end
end
