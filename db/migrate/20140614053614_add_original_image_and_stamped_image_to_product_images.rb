class AddOriginalImageAndStampedImageToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :original_image, :string
    add_column :product_images, :stamped_image, :string
    add_column :product_images, :last_stamped_at, :datetime
    add_reference :product_images, :stamp, index: true
  end
end
