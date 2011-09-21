module Newsly
  class Mailer < ActionMailer::Base
    #include Resque::Mailer
      	
    #TODO: needs to be refactored accordingly to notification and Newsly::Template!
    def newsletter(newsletter_id, options = {})
  		@newsletter = Newsly::Newsletter.find(newsletter_id)
      @options    = options
      @options = @options.merge({"newsletter" => @newsletter})
  		mail(:to => email, :subject => "#{@newsletter.title}")
  	end

    def notification(template_name, template_type, from, to, template_data = {}, headers = {})
      @tpl = Newsly::Template.where(:name => template_name.to_s, :template_type => template_type).first
      @template_data = template_data
      headers[:subject] = "#{@tpl.subject}"
      headers[:to] = to.to_s
      headers[:from] = from.to_s
      mail(headers)
    end

	end
end