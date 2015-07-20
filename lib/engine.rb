# The engine file add the gem's migration to the Rails app it is located in

class StaticSearch::Engine < ::Rails::Engine
  isolate_namespace StaticSearch

  config.autoload_paths += Dir["#{config.root}/lib/**/"]
  initializer :append_migrations do |app|
    unless app.root.to_s.match root.to_s
      config.paths["db/migrate"].expanded.each do |expanded_path|
        app.config.paths["db/migrate"] << expanded_path
      end
    end
  end

end
