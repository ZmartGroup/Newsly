# encoding: UTF-8
module Newsly
  class Newsletter < ActiveRecord::Base
  	liquid_methods :title, :body


  	def render(options={})
  		Liquid::Template.parse(self.body).render options
  	end
  end
end
