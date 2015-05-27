require "static_search/version"
require 'engine' if defined?(Rails)
require 'nokogiri'

Dir["lib/tasks/**/*.rake"].each { |ext| load ext } if defined?(Rake)

module StaticSearch
end

