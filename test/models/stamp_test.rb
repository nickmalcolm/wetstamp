require 'test_helper'

class StampTest < ActiveSupport::TestCase
  
  test "factory is valid" do
    assert FactoryGirl.build_stubbed(:stamp).valid?
  end

  test "defaults are assigned" do
    stamp = FactoryGirl.create(:stamp, rotate: nil, transparency: nil, position: nil)
    assert_equal 0, stamp.rotate
    assert_equal 1, stamp.transparency
    assert_equal Magick::CenterGravity.to_i, stamp.position
  end

end
