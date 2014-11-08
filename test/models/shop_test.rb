require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  
  test "factory is valid" do
    assert FactoryGirl.build_stubbed(:shop).valid?
  end

end
