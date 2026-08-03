Rails.application.routes.draw  do
  namespace :api do
    namespace :v1 do
      # POST /api/v1/progress_logs で create アクションが動くように設定
      resources :progress_logs, only: [ :create ]
      get "health", to: "health#index"
    end
  end
end

