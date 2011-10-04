100.times do |i|
	Customer.create({:first_name => "Kim", :last_name => "Fransman", :email => "kim.fransman+1#{i}1@gmail.com", :company => false})
end
Newsly::Template.create({:name => "newsletter", :body => "{{newsletter.body}}", :subject => "Nyhetsbrev", :draft => false})