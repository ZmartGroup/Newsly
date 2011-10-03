# encoding: UTF-8
module Newsly
  class Mailer < ActionMailer::Base

    default :from => Newsly.default_from, :return_path => Newsly.return_path

    def build_newsletter(newsletter_id, to, template_data = {}, extra_headers = {})
  		@newsletter = Newsly::Newsletter.find(newsletter_id)
      @template = Newsly::Template.where(:name => "newsletter", :draft => false).first
      @template_data = template_data.merge({"newsletter" => {"body" => @newsletter.render(template_data)}})
      @extra_headers = {:subject => "#{@newsletter.title}"}.merge(extra_headers)
      self.build_mail(@template.id, to, @template_data, @extra_headers)
  	end

    def build_mail(template_id, to, template_data = {}, extra_headers = {})
      headers = {}
      tmpl = Newsly::Template.find(template_id)
      headers[:to] = to
      headers[:subject] = tmpl.subject
      body = tmpl.render(template_data)
      headers = headers.merge(extra_headers)
      mail(headers) do |format|
        format.html { render :inline => body, :layout => "newsly/mailer" }
      end
    end

    def self.render_body(template_name, template_type, template_data = {})
      tpl = Newsly::Template.where(:name => template_name.to_s, :template_type => template_type, :draft => false).first
      tpl.render(template_data)
    end

	end
end