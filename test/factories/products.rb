# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    shop
    sequence(:shopify_id)
  end
end
