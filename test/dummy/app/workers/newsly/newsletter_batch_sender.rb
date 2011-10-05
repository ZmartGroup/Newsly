module Newsly
	class NewsletterBatchSender
	  @queue = :newsletter
	  def self.perform(newsletter_id, recipient_group, batch_size)

	  	newsletter = Newsly::Newsletter.find(newsletter_id)
	  	customer = Customer.find_or_create_by_first_name("Newsletter #{newsletter_id}")

	    Newsly.get_newsletter_receipient_group(recipient_group.to_sym).call(newsletter_id).limit(batch_size).each do |resource|
	      Newsly::Mailer.async_deliver.build_newsletter(newsletter_id, resource.send(Newsly.resource_email_column), resource.to_liquid, {:email_type => customer.id.to_s})
	    end
    end

	end
end