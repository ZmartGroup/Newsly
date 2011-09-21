# desc "Explaining what the task does"
# task :newsly do
#   # Task goes here
# end
require "resque/tasks"  
  
task "resque:setup" => :environment 