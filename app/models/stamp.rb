class Stamp < ActiveRecord::Base

  POSITIONS = [
    Magick::NorthWestGravity.to_i,  Magick::NorthGravity.to_i,  Magick::NorthEastGravity.to_i,
    Magick::WestGravity.to_i,       Magick::CenterGravity.to_i, Magick::EastGravity.to_i,
    Magick::SouthWestGravity.to_i,  Magick::SouthGravity.to_i,  Magick::SouthEastGravity.to_i
  ]

  belongs_to :shop
  belongs_to :stamp_image

  validates :shop, presence: true
  validates :stamp_image, presence: true
  validates :rotate, numericality: {greater_than_or_equal_to: -360, less_than_or_equal_to: 360}
  validates :transparency, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
  validates :position, inclusion: POSITIONS

  before_validation :assign_defaults, on: :create

  private

    def assign_defaults
      self.rotate = 0 if self.rotate.blank?
      self.transparency = 1 if self.transparency.blank?
      self.position = Magick::CenterGravity.to_i if self.position.blank?
      true
    end
end
