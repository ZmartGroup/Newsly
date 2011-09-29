require "newsly/engine"
require "resque"
require "resque_mailer"
require "liquid"
require "sanitize"

module Newsly

  mattr_accessor :test_data, :resource_email_column, :recipient_groups, :test_receiver
  @@test_data = {}
  @@recipient_groups = {}
  @@resource_email_column = :email
  @@test_receiver = "tester@newsly.com"

  def self.setup
    yield self
  end

  def self.define_newsletter_receipient_group(group, &block)
    @@recipient_groups[group] = block
  end

  def self.get_newsletter_receipient_group(group)
    @@recipient_groups[group]
  end

end
