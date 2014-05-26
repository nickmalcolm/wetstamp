class AddStampImageIdToStamps < ActiveRecord::Migration
  def change
    add_reference :stamps, :stamp_image, index: true
  end
end
