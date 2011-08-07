ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  def setup
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:get, 'http://sex.chatreach.com:80/geo?address=613%20Sandusky%20Ave%20Kansas%20City,%20KS%2066101', :body => File.read("#{Rails.root}/test/fake/geo"))      
      FakeWeb.register_uri(:get, 'http://sex.chatreach.com:80/geo?address=19905%20S%20Clinton%20Olathe,%20KS%2066215', :body => File.read("#{Rails.root}/test/fake/geo"))      
      FakeWeb.register_uri(:get, 'http://maps.google.com:80/maps/geo?q=66101&key=ABQIAAAAzMUFFnT9uH0xq39J0Y4kbhTJQa0g3IQ9GZqIMmInSLzwtGDKaBR6j135zrztfTGVOm2QlWnkaidDIQ&sensor=false&output=kml', :body => File.read("#{Rails.root}/test/fake/google_geo_zip"))      
  end

  # Add more helper methods to be used by all tests here...
end
