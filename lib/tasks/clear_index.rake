namespace :static do
  task :clear , [:path] => :environment do |t, args|

    require 'static_search/index_builder'

    pages_path = "#{Rails.root}/app/views/pages"

    unless Dir.exists? pages_path
      raise "Pages directory doesn't exists. Please create it in #{pages_path}"
    end

    StaticContent.destroy_all
  end
end