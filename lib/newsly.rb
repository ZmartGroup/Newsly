require "newsly/engine"
require "resque"
require "resque_mailer"
require "liquid"
require "sanitize"

module Newsly

	# Custom domain for cookies. Not set by default
  mattr_accessor :test_data, :resource_email_column
  @@test_data = {}
  @@recipient_group = {}
  @@resource_email_column = :email

  def self.setup
    yield self
  end

  def self.define_newsletter_receipient_group(group, &block)
    @@recipient_group[group] = block
  end

  def self.get_newsletter_receipient_group(group)
    @@recipient_group[group]
  end

end
