Rails.application.routes.draw do
  devise_for :workers, controllers: { registrations: "workers/registrations"}

  root 'home#index'
end
