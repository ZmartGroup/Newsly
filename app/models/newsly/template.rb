# encoding: UTF-8
module Newsly
  class Template < ActiveRecord::Base
  	liquid_methods :body

    scope :find_by_caller, lambda { |mailer, method|
      where(:mailer => mailer, :method => method)
    }

    #these 2 methods are duplicated in newsletter.rb.. DRY up!
  	def render(options={})
  		Liquid::Template.parse(self.body).render options
  	end

  	def render_text(options={})
  		Liquid::Template.parse(self.text_body).render options
  	end

  end
end
