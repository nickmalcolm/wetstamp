class ApplicationController < ActionController::Base
  protect_from_forgery

  # It will re-login if a user tries to access the application from a different shop
  before_filter :login_again_if_different_shop
  
  def current_shop
    if session[:shop_id]
      @current_shop ||= Shop.find(session[:shop_id])
    end
  end
  helper_method :current_shop
  
end
