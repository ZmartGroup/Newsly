## Generic newsly steps
#------------------------------------------------------------------------------
Given /^some templates exists$/ do
  Newsly::Template.create({:name => "cc_welcome", :template_type => "Person", :body => "Hello {{name}} is {{email}} correct?", :subject => "Welcome", :draft => false})
  Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} correct?", :subject => "Welcome", :draft => false})
end

