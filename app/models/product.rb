class Product < ActiveRecord::Base
  belongs_to :shop

  validates :shop, presence: true
  validates :shopify_id, presence: true
  
end
