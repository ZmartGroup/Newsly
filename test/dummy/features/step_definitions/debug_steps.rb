# DEBUG / DELAY STEPS
#------------------------------------------------------------------------------

When /^(?:|I )sleep for (\d+) seconds?$/ do |seconds|
  sleep(seconds.to_i)
end

When /^I debug$/ do
  puts 'Debugging...'
  require 'debug'
  debugger
end
