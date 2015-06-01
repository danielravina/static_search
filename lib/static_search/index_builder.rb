class StaticSearch::IndexBuilder

  require File.dirname(File.expand_path '../..', __FILE__) + '/app/models/static_content.rb'

  def build(pages_path)
    Dir["#{pages_path}/**/*"].each do |fname|
      unless File.directory? fname
        html     = parse_file fname
        filename = parse_action fname
        text     = to_text html
        save_content(text, filename)
      end
    end
    puts "-- Completed"
  end

  def save_content (text, action)
    puts "Indexing #{action} page"
    static_content = StaticContent.find_or_initialize_by(controller_action: action)
    static_content.update content: text
  end


  def parse_file(fname)
    file = File.read(fname)
    ERB.new file, nil, "%"
  end

  def to_text (html)
    html = Nokogiri.HTML html.result
    html.css('script').remove
    html.css("body")
        .text
        .gsub("\n"," ")
        .gsub(/(\s{2,})/," ")
        .strip
  end

  def parse_action(fname)
    filename = fname.split("/").last
    if filename.match(/\./)
      return filename.split(".").first
    else
      return filename
    end
  end

end