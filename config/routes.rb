Rails.application.routes.draw do
  root 'home#index'

  devise_for :admins

  devise_for :workers, controllers: { registrations: "workers/registrations",
                                      sessions: 'workers/sessions' }

  namespace :manages do
    resources :admins, only: %i[ index ]
  end
end
