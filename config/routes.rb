Rails.application.routes.draw  do
  devise_for :users, path: 'api/v1', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations'
  }

  
  namespace :api do
    namespace :v1 do
      # POST /api/v1/progress_logs で create アクションが動くように設定
      resources :progress_logs, only: [ :create ]
      resources :users, only: %i[create]
      get "health", to: "health#index"
      get 'me', to: 'users#me'
      get 'test',to: 'users#test'
    end
  end
end

