# encoding: utf-8

class WetstampUploader < CarrierWave::Uploader::Base
  storage :fog

  # Include RMagick support:
  include CarrierWave::RMagick

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # A white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
