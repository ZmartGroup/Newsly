module Newsly
	class NewsletterSender
	  @queue = :newsletter
	  def self.perform(newsletter_id, recipient_groups)
      for group in recipient_groups
	      Newsly.get_newsletter_receipient_group(group.to_sym).call(newsletter_id).find_each(:batch_size => 1000) do |resource|
	        Newsly::Mailer.async_deliver.build_newsletter(newsletter_id, resource.send(Newsly.resource_email_column), resource.to_liquid)
	      end
    	end

    end

	end
end