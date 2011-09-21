module Newsly
  class Mailer < ActionMailer::Base
    #include Resque::Mailer  	
  	def newsletter(newsletter_id, options = {})
  		@newsletter = Newsly::Newsletter.find(newsletter_id)
      @options    = options
      @options = @options.merge({"newsletter" => @newsletter})
  		mail(:to => email, :subject => "#{@newsletter.title}")
  	end

    def notification(template_name, options = {})
      @tpl = Newsly::Template.where(:name => template_name.to_s, :template_type => options[:template_type]).first
      @options = options
      mail(:to => options[:to], :from => options[:from], :subject => "#{@tpl.subject}", :headers => options[:headers])
    end

	end
end