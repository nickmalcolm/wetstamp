class RemoveImageFromStamps < ActiveRecord::Migration
  
  def up
    remove_column :stamps, :image
  end
  def down
    add_column :stamps, :image, :string
  end

end
