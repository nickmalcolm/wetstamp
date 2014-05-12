# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stamp do
    shop
    rotate 0
    transparency 1
    position Magick::CenterGravity.to_i
  end
end
