require "newsly/engine"
require "resque"
require "resque_mailer"
require "liquid"
require "sanitize"

module Newsly

  mattr_accessor :test_data, :resource_email_column, :test_receiver
  @@test_data = {}
  @@recipient_group = {}
  @@resource_email_column = :email
  @@test_receiver

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
