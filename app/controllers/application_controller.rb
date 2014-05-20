class ApplicationController < ActionController::Base
  protect_from_forgery

  def shopify_session
    if current_shop
      begin
        @current_shop.connect_to_shopify
        yield
      ensure 
        ShopifyAPI::Base.clear_session
      end
    else
      session[:return_to] = request.fullpath if request.get?
      redirect_to login_path
    end
  end
  
  def current_shop
    if session[:shop_id]
      @current_shop ||= Shop.find(session[:shop_id])
    end
  end
  helper_method :current_shop

  def require_shop
    if current_shop.nil?
      session[:return_to] = request.fullpath if request.get?
      redirect_to login_path
    end
  end
  
end
