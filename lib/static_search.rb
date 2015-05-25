require "static_search/version"
require 'engine' if defined?(Rails)
require 'nokogiri'

Dir["lib/tasks/**/*.rake"].each { |ext| load ext } if defined?(Rake)

module StaticSearch
  class Index
    def build(pages_path)
      Dir["#{pages_path}/*"].each do |fname|
        file = File.read(fname)
        html = ERB.new file, nil, "%"
        strip_html html
      end
    end

    private

    def strip_html (html)
      html = Nokogiri.HTML html.result
      p html.children
    end
  end


  class Search
    def self.find_content(q)
      StaticContent.where("content like %?%", q);
    end
  end
end

