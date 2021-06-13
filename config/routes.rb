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
    put 'company/alter-token', to: 'companies#reset_token'
  end
end
