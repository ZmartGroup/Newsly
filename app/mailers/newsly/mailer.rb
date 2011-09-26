# encoding: UTF-8
module Newsly
  class Mailer < ActionMailer::Base
    #include Resque::Mailer

    default :from => "Newsly <noreply@newsly.com>"
    
    def mail(headers = {}, &block)
      caller = caller[0][/`.*'/][1..-2] if caller

      template_data = headers.delete(:template_data)
      template_id   = headers.delete(:template_id)
      template_name = headers.delete(:template_name)

      tmpl = if template_id 
        Newsly::Template.find(template_id) 
      elsif template_name
        Newsly::Template.where(:name => template_name, :draft => false).first
      else
        Newsly::Template.find_by_caller(self.class.to_s, caller).where(:draft => false).first
      end

      if tmpl 
        headers[:subject] ||= tmpl.subject
        mail_body = tmpl.render(template_data)
        super(headers) do |format|
          format.html { render :text => mail_body }
          format.text { render :text => Sanitize.clean(mail_body) }
        end
      else
        super(headers, &block)
      end
    end

    def newsletter(newsletter_id, email, options = {})
  		@newsletter = Newsly::Newsletter.find(newsletter_id)
      mail_body = newsletter.render options.merge({"newsletter" => @newsletter})
  		ActionMailer::Base.mail(:to => email, :subject => "#{@newsletter.title}") do |format|
        format.html { render :text => mail_body }
        format.text { render :text => Sanitize.clean(mail_body) }
      end
  	end

    def send_mail(template_id, to, template_data = {})
      mail(:to => to, :template_id => template_id, :template_data => template_data)
    end

    def self.render_body(template_name, template_type, template_data = {})
      tpl = Newsly::Template.where(:name => template_name.to_s, :template_type => template_type, :draft => false).first
      tpl.render(template_data)
    end

	end
end