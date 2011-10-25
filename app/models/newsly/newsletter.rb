# encoding: UTF-8
module Newsly
  class Newsletter < Newsly::LiquidModel
    set_table_name 'newsly_newsletters'
  	liquid_methods :title, :body

    validates_presence_of :title

    ### Methods

    #
    # return true if never sent or batch_sent
    #
    def draft?
      self.sent? || self.batch_sent? ? false : true
    end
 
    #
    # Returns the status a string. TODO, make nicer!
    #
    def status
      return "draft" if self.draft?
      return "sent" if self.sent?
      return "batch" if self.batch_sent?
    end

  end
end
