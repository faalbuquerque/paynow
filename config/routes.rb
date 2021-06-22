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
    resources :payment_methods, only: %i[ index new create edit update ]
    put 'company/alter-token', to: 'companies#reset_token'
  end

  resources :pix_methods, only: %i[ index show new create edit update ]
  resources :card_methods, only: %i[ index show new create edit update ]
  resources :billet_methods, only: %i[ index show new create edit update  ]

  resources :products, only: %i[ index new create show edit update]
  resources :discounts, only: %i[ new create show]

  namespace :api do
    namespace :v1 do
      resources :clients, only: %i[ index show create ]
      resources :billet_billings, only: %i[ create ]
      resources :card_billings, only: %i[ create ]
      resources :pix_billings, only: %i[ create ]
    end
  end
end
