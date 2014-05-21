class CreateStampImages < ActiveRecord::Migration
  def change
    create_table :stamp_images do |t|
      t.references :shop, index: true
      t.string :image

      t.timestamps
    end
  end
end
