Rails.application.routes.draw do
  resources :bugsnag_errors, only: [:create]
end
