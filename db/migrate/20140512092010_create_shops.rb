class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :domain
      t.string :name
      t.integer :shopify_id
      t.string :api_password
      t.string :email
      t.string :owner
      t.string :notifier_token

      t.timestamps
    end
  end
end
