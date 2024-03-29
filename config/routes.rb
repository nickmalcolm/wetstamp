Rails.application.routes.draw do

  resources :stamps do
    collection do
      post 'upload', to: "watermarks#create"
    end
    member do 
      get :preview
    end
  end

  resources :stamped_images, only: [:index, :show]
  
  controller :sessions do  
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end

  root to: 'home#index'
end
