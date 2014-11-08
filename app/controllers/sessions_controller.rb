class SessionsController < ApplicationController
  def new
    authenticate if params[:shop].present?
  end

  def create
    authenticate
  end
  
  def show
    if response = request.env['omniauth.auth']

      # Create, or Find & Update, the Shop
      shop = Shop.find_or_initialize_by(domain: params[:shop])
      shop.api_password = response['credentials']['token']
      shop.save

      Resque.enqueue(SyncShopProducts, shop.id)

      session[:shop_id] = shop.id

      redirect_to return_address, notice: "Logged in"
    else
      flash[:error] = "Could not log in to Shopify store."
      redirect_to :action => 'new'
    end
  end
  
  def destroy
    session[:shop_id] = nil
    flash[:notice] = "Successfully logged out."
    
    redirect_to :action => 'new'
  end
  
  protected
  
  def authenticate
    if shop_name = sanitize_shop_param(params)
      redirect_to "/auth/shopify?shop=#{shop_name}"
    else
      redirect_to return_address
    end
  end
  
  def return_address
    session[:return_to] || root_url
  end
  
  def sanitize_shop_param(params)
    return unless params[:shop].present?
    name = params[:shop].to_s.strip
    name += '.myshopify.com' if !name.include?("myshopify.com") && !name.include?(".")
    name.sub!(%r|https?://|, '')

    u = URI("http://#{name}")
    u.host.ends_with?(".myshopify.com") ? u.host : nil
  end

end
