require 'spec_helper'
require 'httparty'
require 'static_search/index_builder'

require File.dirname(File.expand_path '../', __FILE__) + '/app/models/static_content.rb'

describe StaticSearch::IndexBuilder do
  describe "build" do
    let(:index_builder)     { StaticSearch::IndexBuilder.new }
    let(:example_direcotry) { 'spec/pages' }
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
      text       = index_builder.parse_content parsed_erb
      expect(text).to be_kind_of String
      expect(text[0]).to_not be_empty
    end

    it "Saves raw HTML" do
      parsed_erb = index_builder.parse_file example_file
      text       = index_builder.parse_content parsed_erb, keep_tags: true
      title      = index_builder.parse_title example_file
      index_builder.save_content text, title
      static_content = StaticContent.first
      expect(static_content.content).to include "<body"
    end

    it "saves the content" do
      parsed_erb = index_builder.parse_file(example_file)
      text       = index_builder.parse_content parsed_erb
      title     = index_builder.parse_title example_file

      expect(index_builder.save_content(text, title)).to be_kind_of StaticContent
      static_content = StaticContent.first
      expect(StaticContent.count).to eq 1
      expect(static_content.title).to eq "example"
      expect(static_content.content).to_not match(/<div|<script|<noscript|<a/)
    end

    it "includes the sub-directory in the file name" do
      sub_dir  =  "sub"
      filename = "subtest"
      new_dir  = "#{example_direcotry}/#{sub_dir}/"
      unless Dir.exists? new_dir
        Dir.mkdir(new_dir)
      end
      temp_file = File.new(new_dir << filename + ".html", "w")
      p
      title     = index_builder.parse_title temp_file.path
      expect(title).to eq sub_dir + "/" + filename
    end

  end
end