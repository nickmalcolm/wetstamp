class SyncShopProducts

  @queue = :default

  MAX_SHOPIFY_PRODUCTS = 250

  def self.perform(shop_id, options={})
    puts "[SyncShopProducts] Performing for Shop ##{shop_id} with options #{options}"
    @shop = Shop.find(shop_id)
    @shop.connect_to_shopify

    self.sync_products(options)

    puts "[SyncShopProducts] Job done."
  end

  private

    def self.sync_products(options)
      options[:page]  ||= 1
      options[:limit] ||= MAX_SHOPIFY_PRODUCTS

      loop do
        puts "[SyncShopProducts] Fetching products with options #{options}"

        products = ShopifyAPI::Product.all(options)
        puts "[SyncShopProducts] #{products.count} Products to sync"

        products.each do |shopify_product|
          sync_product(shopify_product)
        end

        if products.count < options[:limit]
          break
        else
          puts "[SyncShopProducts] Queueing sync of more products"
          options[:page] += 1
        end
      end
    end

    def self.sync_product(shopify_product)
      product = @shop.products.find_or_initialize_by(shopify_id: shopify_product.id)
      product.title = shopify_product.title
      product.save

      shopify_product.images.each do |shopify_product_image|
        sync_product_image(product, shopify_product_image)
      end
    end

    def self.sync_product_image(product, shopify_product_image)
      product_image = product.product_images.find_or_initialize_by(
        shopify_id: shopify_product_image.id
      )
      product_image.source_url = shopify_product_image.src
      product_image.save

      Resque.enqueue(ProductImageDownloader, product_image.id)
    end

end