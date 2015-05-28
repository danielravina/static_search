require 'spec_helper'
require 'httparty'
require 'static_search/index_builder'

require File.dirname(File.expand_path '../', __FILE__) + '/app/models/static_content.rb'

describe StaticSearch::IndexBuilder do
  describe "build" do
    let(:index_builder)     { StaticSearch::IndexBuilder.new }
    let(:example_direcotry) { 'spec/tmp' }
    let(:example_file)      { "#{example_direcotry}/example.html" }
    let(:exampl_url)        { 'http://en.wikipedia.org/wiki/Special:Random' }

    before do
      unless Dir.exists? example_direcotry
        Dir.mkdir(example_direcotry)
      end
      if File.exists? (example_file)
        File.delete(example_file)
      end
        response  = HTTParty.get(exampl_url)
        temp_file = File.new(example_file, "w")
        temp_file.puts response.parsed_response
        temp_file.close
    end

    it "parses the file" do
      parsed_erb = index_builder.parse_file(example_file)
      expect(parsed_erb).to be_kind_of ERB
    end

    it "converts HTML to text" do
      parsed_erb = index_builder.parse_file(example_file)
      text       = index_builder.to_text parsed_erb
      expect(text).to be_kind_of String
      expect(text[0]).to_not be_empty
    end

    it "saves the content" do
      parsed_erb = index_builder.parse_file(example_file)
      text       = index_builder.to_text parsed_erb
      url        = index_builder.parse_url example_file

      expect(index_builder.save_content(text, url)).to be_kind_of StaticContent
      expect(StaticContent.count).to eq 1
      expect(StaticContent.first.filename).to eq "example"
      expect(StaticContent.first.content).to_not match(/<div|<script|<noscript|<a/)
    end

  end
end