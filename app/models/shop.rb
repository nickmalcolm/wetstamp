class Shop < ActiveRecord::Base
  class ShopifySessionInvalidError < StandardError; end

  has_many :stamps

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

end
