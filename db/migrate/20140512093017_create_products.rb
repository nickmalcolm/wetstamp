class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :shop, index: true
      t.integer :shopify_id
      t.string :title

      t.timestamps
    end
  end
end
