namespace :static do

  task :remove_seed , [:path] => :environment do |t, args|

    require 'static_search/index_builder'

    puts "This action will override existing data.\nAre you sure you want to continue? [Y/N]"
    user_confirm = STDIN.gets

    if !!(user_confirm =~ /Y|y|Yes|yes|YES/)
      pages_path = "#{Rails.root}/app/views/pages"
      p "Removing page content"

      unless Dir.exists? pages_path
        raise "Pages directory doesn't exists. Please create it in #{pages_path}"
      end

      Dir["#{pages_path}/**/*"].each do |fname|
        unless File.directory? fname
          page = File.open(fname, "w")
          page.puts ""
          page.close
        end
      end
    end
  end
end