module Newsly
  
  attr_accessor :recipient_group
  
  def define_newsletter_receipient_group(group, &block)
    
    recipient_group ||= Hash.new

    recipient_group[group] = &block

  end

end