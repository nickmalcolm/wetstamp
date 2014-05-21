require 'fog/aws/storage'
require 'carrierwave'
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIVMLOPO7P45ZSYAA',
    :aws_secret_access_key  => '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',
    :region                 => 'us-west-2',
  }
  config.fog_directory  = 'wetstamp-dev'
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end