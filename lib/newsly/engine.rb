module Newsly

  class Engine < Rails::Engine
    isolate_namespace Newsly

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    config.after_initialize do |app|
    	@@models = ActiveRecord::Base.send(:subclasses)
      Dir["#{app.root}/app/models/*"].each do |file|
         @@model = File.basename(file, ".*").classify
         Newsly.test_data.merge!(@@model.constantize.newsly_test_data)
      end
  	end
   
  end

end