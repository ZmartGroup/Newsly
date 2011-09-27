module Newsly
	class NewsletterSender
	  @queue = :newsletter
	  def self.perform(newsletter_id, template_id)
      
      Newsly.get_newsletter_receipient_group(:newsletter_resources).call do |resource|

        Newsly::Mailer.send_newsletter(newsletter_id, resource.send(Newsly.resource_email_column), resource.to_liquid).deliver   
      end

    end

	end
end