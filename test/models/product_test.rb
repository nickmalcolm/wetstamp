require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  test "factory is valid" do
    assert FactoryGirl.build_stubbed(:product).valid?
  end

end
