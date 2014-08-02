ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def log_in(shop)
    Shop.any_instance.stubs(:connect_to_shopify)
    session[:shop_id] = shop.id
  end

  # Add more helper methods to be used by all tests here...
end

require 'mocha/mini_test'
