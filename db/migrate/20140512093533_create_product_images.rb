class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.references :product, index: true
      t.integer :shopify_id

      t.timestamps
    end
  end
end
