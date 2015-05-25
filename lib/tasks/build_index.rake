task :build_index , [:path] => :environment do |t, args|
  pages_path = "#{Rails.root}/app/views/pages"

  unless Dir.exists? pages_path
    raise "Pages directory doesn't exists. Please create it in #{pages_path}"
  end

  index_builder = StaticSearch::Index.new
  index_builder.build(pages_path)
end
