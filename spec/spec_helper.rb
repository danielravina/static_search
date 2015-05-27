require 'bundler/setup'
Bundler.setup

require 'static_search'
require 'active_record'

RSpec.configure do |config|
  # some (optional) config here
end


ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load File.dirname(__FILE__) + '/schema.rb'
