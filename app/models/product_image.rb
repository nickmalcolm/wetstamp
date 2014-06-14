class ProductImage < ActiveRecord::Base
  belongs_to :product

  validates :product, presence: true
  validates :shopify_id, presence: true, uniqueness: true

end
