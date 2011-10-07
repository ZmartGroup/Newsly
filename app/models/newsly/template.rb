# encoding: UTF-8
module Newsly
  class Template < ActiveRecord::Base

  	liquid_methods :subject, :body

  	validates_presence_of :subject
  	validates_presence_of :body
  	#validates_presence_of :parent_id, :if => :original
  	#validates original is never draft and

  	def render(options={})
      Liquid::Template.parse(self.body).render options
    end
  	
  	def publish
  		original = Newsly::Template.find(self.parent_id)
      original.subject = self.subject
      original.body = self.body
      original.save
  	end
  
	end
end
