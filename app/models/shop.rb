class Shop < ActiveRecord::Base
  class ShopifySessionInvalidError < StandardError; end

  has_many :stamps
  has_many :stamp_images

  validates :domain, presence: {allow_blank: false}, uniqueness: true

  
  def admin_url
    "https://#{self.domain}/admin"
  end

  def connect_to_shopify
    # Check if we're already connected
    unless ShopifyAPI::Base.site.try(:to_s).eql? self.admin_url
      # Nope. Connect.
      session = ShopifyAPI::Session.new(self.domain, self.api_password)
      ShopifyAPI::Base.activate_session(session)
      if !session.valid?
        raise ShopifySessionInvalidError, "Shopify session for domain #{self.domain} is invalid."
      end
    end
  end

  def sync
    connect_to_shopify

    ShopifyAPI::Product.all.each do |shopify_product|
      product = Product.create_with(shop: self).find_or_create_by(shopify_id: shopify_product.id)
      product.title = shopify_product.title
      product.save

      shopify_product.images.each do |shopify_product_image|
        product_image = ProductImage.create_with(product: product).find_or_create_by(shopify_id: shopify_product_image.id)
      end

    end
  end

end
