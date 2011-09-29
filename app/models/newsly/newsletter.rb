# encoding: UTF-8
module Newsly
  class Newsletter < ActiveRecord::Base
  	liquid_methods :title, :body


    #these 2 methods are duplicated in template.rb.. DRY up!
  	def render(options={})
  		Liquid::Template.parse(self.body).render options
  	end
  	
  end
end
