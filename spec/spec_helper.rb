require 'chefspec/berkshelf'
require 'chefspec'
require_relative 'support/matchers/nginx_site'

at_exit { ChefSpec::Coverage.report! }