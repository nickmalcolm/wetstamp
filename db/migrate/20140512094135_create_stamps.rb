class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.references :shop, index: true
      t.string :name
      t.string :image
      t.decimal :rotate,        precision: 5, scale: 2 # -123.56
      t.decimal :transparency,  precision: 3, scale: 2 # 0.12
      t.integer :position
      t.boolean :tiled

      t.timestamps
    end
  end
end
