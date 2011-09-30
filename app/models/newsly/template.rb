# encoding: UTF-8
module Newsly
  class Template < ActiveRecord::Base
  	liquid_methods :body

  	def render(options={})
  		Liquid::Template.parse(self.body).render options
  	end

  end
end
