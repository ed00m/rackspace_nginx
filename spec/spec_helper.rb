require 'chefspec'
require 'chefspec/berkshelf'
require_relative 'support/matchers/nginx_site'

at_exit { ChefSpec::Coverage.report! }
