require 'spec_helper'
require 'httparty'

describe "StaticSearch::IndexBuilder" do
  describe "build" do
    let(:indexer)   { StaticSearch::Index.new }
    let(:temp_path) { 'spec/temp/' }
    let(:example)   { "#{temp_path}/example.html"}

    before do
      unless File.exists? (example)
        Dir.mkdir(temp_path)
        response  = HTTParty.get('http://example.com')
        temp_file = File.new(example, "w")
        temp_file.puts response.parsed_response
      end
    end

    it "should load the pages path" do
      p temp_path
      indexer.build temp_path
    end


  end
end