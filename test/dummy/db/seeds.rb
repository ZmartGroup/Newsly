Customer.create({:first_name => "Kim", :last_name => "Fransman", :email => "kim@baraspara.se", :company => false})
Customer.create({:first_name => "Fredrik", :last_name => "Bohlin", :email => "fredrik@baraspara.se", :company => false})
Customer.create({:first_name => "Hej", :last_name => "San", :email => "hejsan@baraspara.se", :company => true})
Newsly::Template.create({:name => "newsletter", :body => "", :draft => false})