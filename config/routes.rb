Rails.application.routes.draw do
  
  resources :stamps do
    collection do
      post 'upload', to: "stamp_images#create"
    end
  end

  controller :sessions do  
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end

  root to: 'home#index'
end
