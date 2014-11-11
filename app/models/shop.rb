class Shop < ActiveRecord::Base
  class ShopifySessionInvalidError < StandardError; end

  has_many :stamps
  has_many :watermarks
  has_many :products
  has_many :product_images, through: :products
  has_many :stamped_images, through: :product_images

  validates :domain, presence: {allow_blank: false}, uniqueness: true

  def admin_url
    "https://#{domain}/admin"
  end

  def connect_to_shopify
    # Check if we're already connected
    unless ShopifyAPI::Base.site.try(:to_s).eql? admin_url
      # Nope. Connect.
      session = ShopifyAPI::Session.new(domain, api_password)
      ShopifyAPI::Base.activate_session(session)
      if !session.valid?
        raise ShopifySessionInvalidError, "Shopify session for domain #{domain} is invalid."
      end
    end
  end

  def queue_sync
    Resque.enqueue(SyncShopProducts, id)
  end

  def current_stamp
    stamps.last
  end

  def previews
    ShopPreviews.new(self)
  end

end
