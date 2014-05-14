Rails.application.routes.draw do
  
  resources :stamps

  controller :sessions do  
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end

  root to: 'home#index'
end
