Rails.application.routes.draw do
  resources :stamps

  root to: 'home#index'
end
