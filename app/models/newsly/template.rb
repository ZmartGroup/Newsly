# encoding: UTF-8

module Newsly
  class Template < Newsly::LiquidModel
    set_table_name 'newsly_templates'
    liquid_methods :subject, :body

    validates_presence_of :subject
    #validates_presence_of :parent_id, :if => :original
    #validates original is never draft and

    
    ### Methods

    #
    # Takes a draft and copies information to the original
    #
    def publish
      original = Newsly::Template.find(self.parent_id)
      original.subject= self.subject
      original.body= self.body
      original.save
      original
    end
    
  end
end
