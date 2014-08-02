class Shop < ActiveRecord::Base
  class ShopifySessionInvalidError < StandardError; end

  has_many :stamps
  has_many :stamp_images
  has_many :products
  has_many :product_images, through: :products

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

  def sync
    Rails.logger.info "Syncing Shop #{domain}"
    connect_to_shopify

    ShopifyAPI::Product.all.each do |shopify_product|
      
      product = products.find_or_initialize_by(shopify_id: shopify_product.id)
      product.title = shopify_product.title
      product.save

      Rails.logger.info "\tSaved Product #{product.id}: #{product.title} (##{shopify_product.id})"

      shopify_product.images.each do |shopify_product_image|
        Rails.logger.info "\t\t Downloading #{shopify_product_image.src}"
        product_image = product.product_images.create_with(remote_original_image_url: shopify_product_image.src).find_or_create_by!(shopify_id: shopify_product_image.id)
        Rails.logger.info "\tSaved ProductImage #{product_image.id}: #{product_image.original_image.url}"
      end

    end
    Rails.logger.info "Done."
  end

end
