Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        member do
          get 'account', to: 'users#account'
        end
      end
      resources :books, only: [:create] do
        member do
          get 'income', to: 'books#income'
          post 'lend/:user_id', to: 'books#lend'
          patch 'return/:user_id', to: 'books#return'
        end
      end
    end
  end
end
