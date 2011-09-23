module Newsly
	class NewsletterSender
	  @queue = :newsletter
	  def self.perform(newsletter_id, template_id)
	    newsletter 	= Newsly::Newsletter.find(newsletter_id)
      
      Newsly.define_newsletter_receipient_group :all_customers.each do |liquid_data|

        Newsly::Mailer.newsletter(@newsletter.id, @template.id).deliver   
        
      end

    end
    


	end
end