require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  
  test "factory is valid" do
    assert FactoryGirl.build_stubbed(:product_image).valid?
  end


end
