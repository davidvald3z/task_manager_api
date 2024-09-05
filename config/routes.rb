Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :branches
      resources :movements
      get 'sales', to: 'movements#index', defaults: { type: 'sales' }
      get 'expenses', to: 'movements#index', defaults: { type: 'expenses' }
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
