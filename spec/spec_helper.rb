require 'bundler/setup'
Bundler.setup

require 'static_search'
require 'active_record'
require 'action_view'
RSpec.configure do |config|
  include ActionView::Helpers::UrlHelper
end

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load File.dirname(__FILE__) + '/schema.rb'
