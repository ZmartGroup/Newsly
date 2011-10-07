# encoding: UTF-8
module Newsly
  class Newsletter < ActiveRecord::Base
  	liquid_methods :title, :body


    def render(options={})
      Liquid::Template.parse(self.body).render options
    end

  	def draft?
  		self.sent? || self.batch_sent? ? false : true
  	end

  	#TODO, make nicer!
  	def status
  		return "draft" if self.draft?
  		return "sent" if self.sent?
  		return "batch" if self.batch_sent?
  	end
  	
  end
end
