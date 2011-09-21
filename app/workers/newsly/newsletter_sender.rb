module Newsly
	class NewsletterSender
	  @queue = :newsletter
	  def self.perform(newsletter_id, template_id)
	    newsletter 	= Newsly::Newsletter.find(newsletter_id)
	    Newsly::Mailer.newsletter(@newsletter.id, @template.id).deliver
	  end
	end
end