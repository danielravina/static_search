namespace :static do

  task :seed , [:path] => :environment do |t, args|

    require 'httparty'
    require 'static_search/index_builder'

    puts "This action will override existing data.\nAre you sure you want to continue? [Y/N]"
    user_confirm = STDIN.gets

    if !!(user_confirm =~ /Y|y|Yes|yes|YES/)
      pages_path = "#{Rails.root}/app/views/pages"
      p "Populating random stuff..."

      unless Dir.exists? pages_path
        raise "Pages directory doesn't exists. Please create it in #{pages_path}"
      end

      random_wiki = 'http://en.wikipedia.org/wiki/Special:Random'

      Dir["#{pages_path}/**/*"].each do |fname|
        unless File.directory? fname
          response  = HTTParty.get(random_wiki)
          page = File.open(fname, "w")
          page.puts response.parsed_response
          page.close
        end
      end
    end
  end
end