class StaticSearch::IndexBuilder

  require File.dirname(File.expand_path '../..', __FILE__) + '/app/models/static_content.rb'

  def build(pages_path, options = {})

    Dir["#{pages_path}/**/*"].each do |fname|
      unless File.directory? fname
        erb      = parse_file fname
        filename = parse_title fname
        text     = parse_content(erb, options[:keep_tags] || {})
        save_content(text, filename)
      end
    end
    puts "-- Completed" if production?
  end

  def save_content (text, title)
    puts "Indexing #{title} page" if production?
    static_content = StaticContent.find_or_initialize_by(title: title)
    static_content.update content: text
    return static_content
  end


  def parse_file(fname)
    file = File.read(fname)
    ERB.new file, nil, "%"
  end

  def parse_content (erb, options = {})
    b = binding
    html = Nokogiri.HTML erb.result b
    html.css('script').remove
    if options[:keep_tags]
      html.css("body")
    else
      html.css("body")
          .text
          .gsub("\n"," ")
          .gsub(/(\s{2,})/," ")
          .strip
    end
  end
  # WORK AROUND TO OVERIDE RAILS METHODS THAT DON"T WORK

  def link_to a=nil,b=nil
  end

  def render path=nil, options=nil
  end

  def content_for a=nil,b=nil
  end

  def raw a=nil,b=nil
  end

  def parse_title(fname)
    filename = fname.split("/pages/").last
    if filename.match(/\./)
      return filename.split(".").first
    else
      return filename
    end
  end

  private

  def production?
    defined?(Rails) || defined?(Rake)
  end
end
