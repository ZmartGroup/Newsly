require "newsly/engine"
require "resque"
require "resque_mailer"
require "liquid"
require "sanitize"

module Newsly

	# Custom domain for cookies. Not set by default
  mattr_accessor :test_data
  @@test_data = {}

  def self.setup
    yield self
  end

end
