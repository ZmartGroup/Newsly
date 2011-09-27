# encoding: UTF-8
module Newsly
  class Mailer < ActionMailer::Base
    include Resque::Mailer

    default :from => "Newsly <noreply@newsly.com>"
    
    def mail(headers = {}, &block)
      caller = caller[0][/`.*'/][1..-2] if caller

      template_data = headers.delete(:template_data)
      template_id   = headers.delete(:template_id)
      template_name = headers.delete(:template_name)
      text_body     = headers.delete(:text_body)

      tmpl = if template_id 
        Newsly::Template.find(template_id) 
      elsif template_name
        Newsly::Template.where(:name => template_name, :draft => false).first
      else
        Newsly::Template.find_by_caller(self.class.to_s, caller).where(:draft => false).first
      end

      if tmpl 
        headers[:subject] ||= tmpl.subject
        mail_body = tmpl.render(template_data).html_safe
        if text_body.nil?
          text_body = tmpl.render_text(template_data).html_safe
        end
        super(headers) do |format|
          format.text { render :text => text_body }
          format.html { render :inline => mail_body, :layout => true }
        end
      else
        super(headers, &block)
      end
    end

    def send_newsletter(newsletter_id, to, template_data = {})
  		@newsletter = Newsly::Newsletter.find(newsletter_id)
      @template = Newsly::Template.where(:name => "newsletter", :draft => false).first
      @template_data = template_data.merge({"newsletter" => {"body" => @newsletter.render(template_data)}})
      @text_body = @newsletter.render_text(@template_data)
      mail(:to => to, :subject => "#{@newsletter.title}", :template_id => @template.id, :template_data => @template_data, :text_body => @text_body)
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