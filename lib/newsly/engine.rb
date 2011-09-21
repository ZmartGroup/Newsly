module Newsly
  class Engine < Rails::Engine
    isolate_namespace Newsly

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
    
  end
end
