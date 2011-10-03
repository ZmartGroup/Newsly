class Customer < ActiveRecord::Base
	def to_liquid
      { 
	      "kund" => {
		      "name" => "#{first_name} #{last_name}",
		      "first_name" => first_name,
		      "last_name" => last_name,
		      "email" => email,
		      "avreglank" => "loremipsumlink"
		    }
	    }
    end
end