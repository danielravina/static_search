class StaticSearch::IndexBuilder

  require File.dirname(File.expand_path '../..', __FILE__) + '/app/models/static_content.rb'

  def build(pages_path)
    Dir["#{pages_path}/*"].each do |fname|
      html     = parse_file fname
      filename = parse_action fname
      text     = to_text html
      save_content(text, filename)
    end
  end

  def save_content (text, action)
    StaticContent.create content: text, controller_action: action
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