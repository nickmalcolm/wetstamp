require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  
  test "factory is valid" do
    assert FactoryGirl.build_stubbed(:shop).valid?
  end

  test "can sync shop" do
    shop = FactoryGirl.create(:shop)
    shop.expects(:connect_to_shopify)

    image = stub(id: 12345)
    product = stub(id: 67890, title: "FooBar")
    product.expects(:images).returns([image])
    ShopifyAPI::Product.expects(:all).returns([product])

    assert_difference ["Product.count", "ProductImage.count"] do
      shop.sync
    end

    product = Product.last
    assert_equal shop, product.shop
    assert_equal 67890, product.shopify_id
    assert_equal "FooBar", product.title

    product_image = ProductImage.last
    assert_equal product, product_image.product
    assert_equal 12345, product_image.shopify_id
  end

end
