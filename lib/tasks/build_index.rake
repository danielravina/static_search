
task :build_index , [:path] => :environment do |t, args|

  require 'static_search/index_builder'

  pages_path = "#{Rails.root}/app/views/pages"

  unless Dir.exists? pages_path
    raise "Pages directory doesn't exists. Please create it in #{pages_path}"
  end

  index_builder = StaticSearch::IndexBuilder.new
  index_builder.build(pages_path)
end
