module Newsly
	class LiquidModel < ActiveRecord::Base

		validates_presence_of :body
		#
    # Puts the parse error from Liquid on the error list if parsing failed
    #
    def after_validation
      errors.add :internal_template, @syntax_error unless @syntax_error.nil?
    end


    ### Attributes
    attr_protected :internal_template


    #
    # body contains the raw internal_template. When updating this attribute, the
    # template parses the internal_template and stores the serialized object
    # for quicker rendering.
    #
    def body=(text)
      self[:body] = text
      begin
        @internal_template = Liquid::Template.parse(text)
        self[:internal_template] = [Marshal.dump(@internal_template)].pack('m*')
      rescue Liquid::SyntaxError => error
        @syntax_error = error.message
      end
    end

    ### Methods
    #
    # Renders body as Liquid Markup template
    #
    def render(options = {})
      internal_template.render options
    end


    private
      #
      # Returns a usable Liquid:Template instance
      #
      def internal_template
        return @internal_template unless @internal_template.nil?
        
        if self[:internal_template].blank?
          @internal_template = Liquid::Template.parse body
          self[:internal_template] = [Marshal.dump(@internal_template)].pack('m*')
          save
        else
          @internal_template = Marshal.load(self[:internal_template].unpack("m")[0])
        end

        @internal_template
      end



	end
end