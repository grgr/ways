require 'active_support/core_ext'
require 'rspec'
require 'ways'

require File.expand_path("../test_app/config/environment", __FILE__)

RSpec.configure do |config|
  config.color = true
end
