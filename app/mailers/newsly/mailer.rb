# encoding: UTF-8
module Newsly
  class Mailer < ActionMailer::Base

    default :from => "Newsly <noreply@newsly.com>"

    def build_newsletter(newsletter_id, to, template_data = {})
  		@newsletter = Newsly::Newsletter.find(newsletter_id)
      @template = Newsly::Template.where(:name => "newsletter", :draft => false).first
      @template_data = template_data.merge({"newsletter" => {"body" => @newsletter.render(template_data)}})
      self.build_mail(@template.id, to, @template_data, {:subject => "#{@newsletter.title}"})
  	end

    def build_mail(template_id, to, template_data = {}, extra_headers = {})
      headers = {}
      tmpl = Newsly::Template.find(template_id)
      headers[:to] = to
      headers[:subject] = tmpl.subject
      headers = headers.merge(extra_headers)
      body = tmpl.render(template_data)
      debugger
      mail(headers) do |format|
        format.text { render :inline => Premailer.new(body, :with_html_string => true).to_plain_text }
        format.html { render :inline => Premailer.new(body, :with_html_string => true).to_inline_css }
      end
    end

    def self.render_body(template_name, template_type, template_data = {})
      tpl = Newsly::Template.where(:name => template_name.to_s, :template_type => template_type, :draft => false).first
      tpl.render(template_data)
    end

	end
end