require "static_search/version"
require 'nokogiri'

if defined?(Rails)
  require 'engine'
  Dir["lib/static_search/**/*.rb"].each { |ext| load ext }
end

if defined?(Rake)
  Dir["lib/tasks/**/*.rake"].each { |ext| load ext }
end

module StaticSearch
end

