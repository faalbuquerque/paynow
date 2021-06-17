Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins

  devise_for :workers, controllers: { registrations: "workers/registrations",
                                      sessions: 'workers/sessions' }

  namespace :admins do
    resources :manages, only: %i[ index ]
  end

  namespace :workers do
    resources :companies, only: %i[ show ]
    resources :accesses, only: %i[ show update ]
    put 'company/alter-token', to: 'companies#reset_token'
  end

  namespace :api do
    namespace :v1 do
      resources :clients, only: %i[ index show create ]
    end
  end

  resources :company_tokens, only: %i[ create ]
end
